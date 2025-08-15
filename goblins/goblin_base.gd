extends RigidBody2D

# THIS CAN BE REWRITTEN USING ClassType.new() TO MAKE NODES IN THE INSTANCED GOBLIN SCENES

signal player_hit

@export var mob_type = "goblin"
@export var attack_damage = 1
@export var speed = 300
@export var health = 100
@export var knockback_impulse = 600000
@export var pool_shot_knockback_impulse = 8000000
@export var player_gravity = 20000
@export var coeff_friction = 70

var player_position: Vector2 = 	Vector2.ZERO
var direction
var distance
var player_node
var gravity_force
var friction_force
var is_pool_shot: bool = false
var goblin_type_dictionary: Dictionary = {
	"basic_goblin": 1,
	"naked_goblin": 2,
	"pirate_goblin": 3,
	"rock_goblin": 4
}
var goblin_type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Chooses a random goblin_type using pick_random function
	goblin_type = pick_random(goblin_type_dictionary)
	
	#Sets Sprite2D texture to the goblin_type corresponding image
	if goblin_type == "basic_goblin":
		$Sprite2D.texture = load("res://art/goblins/basic_goblin.png")
	elif goblin_type == "naked_goblin":
		$Sprite2D.texture = load("res://art/goblins/naked_goblin.png")
	elif goblin_type == "pirate_goblin":
		$Sprite2D.texture = load("res://art/goblins/pirate_goblin.png")
	elif goblin_type == "rock_goblin":
		$Sprite2D.texture = load("res://art/goblins/rock_goblin.png")
		
	#setup from old goblin types
	player_node = get_node("/root/Main/Player")
	follow_physics()
	player_node.player_hit.connect(_on_player_hit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if $FlashTimer:
	#	if not $FlashTimer.is_stopped():
	#		$CanvasModulate.set_color(Color(0.980392, 0.921569, 0.843137, 1))
	pass


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	follow_physics()


func follow_physics():
	player_position = player_node.position
	distance = position.distance_to(player_position)
	direction = position.direction_to(player_position)
	
	#print(str(position))
	
	gravity_force = direction * player_gravity
	friction_force = - get_linear_velocity() * coeff_friction

	apply_central_force(gravity_force)
	apply_central_force(friction_force)
	
	if direction.x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false

func _on_player_hit(damage_source):
	#if damage_source == self: # toggle to only push back the mob that hurt my boy
	get_pushed()
	go_red()

func get_pushed():
	#print(distance)
	apply_impulse(-direction * knockback_impulse * ((distance + 1) ** -0.5))

func go_red():
	#if $FlashTimer:
	#	$FlashTimer.start()
	#	$CanvasModulate.set_color(Color(0.941176, 0.972549, 1, 1))
	pass


func _on_body_entered(body: Node) -> void:
	if body.mob_type == "goblin":
		if body.is_pool_shot == true:
			print("goblin hit goblin")
			apply_impulse(-direction * pool_shot_knockback_impulse * distance)
			

#returns a random key from the goblin_type_dictionary
func pick_random(dictionary: Dictionary):
	var random_goblin_key = goblin_type_dictionary.keys().pick_random()
	return random_goblin_key
