extends Area2D

signal player_position
signal player_hit

@export var dart_scene: PackedScene
@export var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player_position.emit(position)
	
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	
	if Input.is_action_pressed("attack"):
		if $AttackCooldown.is_stopped():
			$AttackCooldown.start()
			var dart = dart_scene.instantiate()
			add_child(dart)

func _on_body_entered(body: Node2D) -> void:
	print("DING")
	player_hit.emit()
	#$CollisionShape2D.set_deferred("disabled", true)
