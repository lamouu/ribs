extends RigidBody2D

@export var speed = 300
@export var health = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var velocity = position.direction_to(Player.global_position)
	
	if velocity.x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	velocity = velocity.normalized() * speed
	
	linear_velocity = velocity
