extends RigidBody2D

# THIS CAN BE REWRITTEN USING ClassType.new() TO MAKE NODES IN THE INSTANCED GOBLIN SCENES

signal player_hit

@export var mob_type = "goblin"
@export var attack_damage = 1
@export var speed = 300
@export var health = 100
@export var knockback_impulse = 50000

var player_position: Vector2 = 	Vector2.ZERO
var velocity
var distance
var player_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if $FlashTimer:
	#	if not $FlashTimer.is_stopped():
	#		$CanvasModulate.set_color(Color(0.980392, 0.921569, 0.843137, 1))
	pass

func follow_physics(state):
	player_position = player_node.position
	distance = position.distance_to(player_position)
	velocity = position.direction_to(player_position)
	

	if velocity.x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	velocity = velocity.normalized() * speed
	
	state.linear_velocity = velocity
	
	if $ImpulseTimer:
		if not $ImpulseTimer.is_stopped():
			apply_impulse(-velocity * knockback_impulse * (1/distance))

func _on_player_hit(damage_source):
	#if damage_source == self: # toggle to only push back the mob that hurt my boy
	get_pushed()
	go_red()

func get_pushed():
	if velocity != Vector2.ZERO:
		if $ImpulseTimer:
			$ImpulseTimer.start()

func go_red():
	#if $FlashTimer:
	#	$FlashTimer.start()
	#	$CanvasModulate.set_color(Color(0.941176, 0.972549, 1, 1))
	pass
