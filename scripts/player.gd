extends CharacterBody2D

signal player_hit
signal player_really_hit
signal inventory_updated

@export var dart_scene: PackedScene
@export var pool_cue_scene: PackedScene
@export var speed = 500
@export var damage = 1
@export var max_health: int = 3
@export var health: int
var score: int
var collision_type = "player"

var inventory: Inventory = Inventory.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var target_velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = velocity.lerp(target_velocity, 1.0 - exp(-20 * get_physics_process_delta_time()))

	position += velocity * delta * speed
	move_and_slide()
	
	if Input.is_action_pressed("attack"):
		if $AttackCooldown.is_stopped():
			$AttackCooldown.start()
			var dart = dart_scene.instantiate()
			add_child(dart)
	
	if Input.is_action_just_pressed("special_attack"):
		if $SpecialAttackCooldown.is_stopped():
			$SpecialAttackCooldown.start()
			var pool_cue = pool_cue_scene.instantiate()
			add_child(pool_cue)

func _on_body_entered(body: RigidBody2D) -> void:
	take_damage(body)
	
func take_damage(attack_damage):
	if $InvulnerabilityTimer.is_stopped():
		#if damage_source.mob_type == "goblin": #unused so far
		#	pass

		health -= attack_damage

		$InvulnerabilityTimer.start()
		$InvulnerabilityAnimation.play("damage_taken")

		player_hit.emit()
		player_really_hit.emit(health)


func _on_invulnerability_timer_timeout() -> void:
	$InvulnerabilityAnimation.stop()

# debug buttons num1, num2, num3 (currently adding items)
func _input(event):
	if event.is_action_pressed("debug_1"):
		inventory.add_item(Items.HAMMER)
		inventory_updated.emit()
		
	if event.is_action_pressed("debug_2"):
		inventory.add_item(Items.BURRITO)
		inventory_updated.emit()
		
	if event.is_action_pressed("debug_3"):
		inventory.add_item(Items.WHETSTONE)
		inventory_updated.emit()
