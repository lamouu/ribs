extends Area2D

signal player_hit

@export var dart_scene: PackedScene
@export var speed = 400
@export var max_health: int = 3
@export var health: int
var score: int

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
			

func _on_body_entered(body: Node2D) -> void:
	take_damage(body)
	
func take_damage(damage_source):
	if $InvulnerabilityTimer.is_stopped():
		if damage_source.mob_type == "goblin": #unused so far
			pass
		
		health -= damage_source.attack_damage
		
		$InvulnerabilityTimer.start()
		$InvulnerabilityAnimation.play("damage_taken")
		
		player_hit.emit(damage_source)


func _on_invulnerability_timer_timeout() -> void:
	$InvulnerabilityAnimation.stop()
