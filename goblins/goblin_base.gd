extends RigidBody2D

# THIS CAN BE REWRITTEN USING ClassType.new() TO MAKE NODES IN THE INSTANCED GOBLIN SCENES

signal player_hit

@export var mob_type = "goblin"
@export var attack_damage = 1
@export var speed = 300
@export var health = 100
@export var knockback_impulse = 600000
@export var player_gravity = 20000
@export var coeff_friction = 70

var player_position: Vector2 = 	Vector2.ZERO
var direction
var distance
var player_node
var gravity_force
var friction_force

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if $FlashTimer:
	#	if not $FlashTimer.is_stopped():
	#		$CanvasModulate.set_color(Color(0.980392, 0.921569, 0.843137, 1))
	pass

func follow_physics():
	player_position = player_node.position
	distance = position.distance_to(player_position)
	direction = position.direction_to(player_position)
	
	print(str(position))
	
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
	print(distance)
	apply_impulse(-direction * knockback_impulse * ((distance + 1) ** -0.5))

func go_red():
	#if $FlashTimer:
	#	$FlashTimer.start()
	#	$CanvasModulate.set_color(Color(0.941176, 0.972549, 1, 1))
	pass
