extends RigidBody2D

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
var impulse_timer_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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

func get_pushed():
	if velocity != Vector2.ZERO:
		if $ImpulseTimer:
			$ImpulseTimer.start()
	
