extends Area2D

signal player_hit

@export var dart_scene: PackedScene
@export var pool_cue_scene: PackedScene
@export var speed = 400
@export var max_health: int = 3
@export var health: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
	
	if Input.is_action_just_pressed("special_attack"):
		var pool_cue = pool_cue_scene.instantiate()
		add_child(pool_cue)

func _on_body_entered(body: Node2D) -> void:
	player_hit.emit()
	take_damage(body)
	
	#$CollisionShape2D.set_deferred("disabled", true)
	
func take_damage(damage_source):
	if $InvulnerabilityTimer.is_stopped():
		if damage_source.mob_type == "goblin": #unused so far
			pass
		
		health -= damage_source.attack_damage
		
		$InvulnerabilityTimer.start()
		$InvulnerabilityAnimation.play("damage_taken")
		
		print("hit to " + str(health) + "hp by " + str(damage_source.mob_type))
	else:
		print("hit by " + str(damage_source.mob_type) + " but invulnerable")


func _on_invulnerability_timer_timeout() -> void:
	$InvulnerabilityAnimation.stop()
