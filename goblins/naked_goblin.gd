extends RigidBody2D

@export var speed = 300
@export var health = 100

var player_position: Vector2 = 	Vector2.ZERO
var velocity
var player_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_node = get_node("../Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _integrate_forces(state):
	player_position = player_node.position
	velocity = position.direction_to(player_position)
	

	if velocity.x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	velocity = velocity.normalized() * speed
	
	state.linear_velocity = velocity
