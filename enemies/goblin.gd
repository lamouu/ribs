extends RigidBody2D

@export var speed = 300
@export var health = 100
var player_position_local: Vector2 = 	Vector2.ZERO
var velocity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var main = get_node("./main")
	main.player_position_signal.connect()
	#player_position_local = main.player_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _integrate_forces(state):
	var velocity = position.direction_to(player_position_local)
	
	
	if velocity.x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	velocity = velocity.normalized() * speed
	
	state.linear_velocity = velocity
