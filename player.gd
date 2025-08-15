extends Area2D

signal player_hit

@export var dart_scene: PackedScene
@export var pool_cue_scene: PackedScene
@export var speed = 500
@export var max_health: int = 3
@export var health: int
var score: int
var velocity: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target_velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-20 * get_physics_process_delta_time()))

	position += velocity * delta * speed
	
	if Input.is_action_pressed("attack"):
		if $AttackCooldown.is_stopped():
			$AttackCooldown.start()
			var dart = dart_scene.instantiate()
			add_child(dart)
	
	if Input.is_action_just_pressed("special_attack"):
		var pool_cue = pool_cue_scene.instantiate()
		add_child(pool_cue)

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
