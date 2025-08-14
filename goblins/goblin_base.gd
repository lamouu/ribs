extends RigidBody2D

@export var mob_type = "goblin"
@export var attack_damage = 1
@export var speed = 300
@export var health = 100

var player_position: Vector2 = 	Vector2.ZERO
var velocity
var player_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func follow_physics(state):
	player_position = player_node.position
	velocity = position.direction_to(player_position)
	

	if velocity.x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	velocity = velocity.normalized() * speed
	
	state.linear_velocity = velocity
