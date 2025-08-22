extends RigidBody2D

@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

@export var goblin_type_resource: Resource
@export var mob_type = "goblin"
@export var attack_damage = 1
@export var speed = 300
@export var health = 100
@export var knockback_impulse = 600000
@export var pool_shot_knockback_impulse = 80
@export var player_gravity = 20000
@export var coeff_friction = 70
@export var pool_damage = 50

var texture: Texture
var player_position: Vector2 = 	Vector2.ZERO
var direction
var distance
var player_node
var gravity_force
var friction_force
var is_pool_shot: bool = false
var is_first_pool_shot: bool = false
var velocity_a
var velocity_b
var goblin_type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# calls a function in goblin_type_resource that returns a random type, and assigns goblin_type_resource variables
	goblin_type = goblin_type_resource.get_random_type()
	$Sprite2D.texture = goblin_type_resource.texture
	$TextureProgressBar.hide()
		#setup from old goblin types
	player_node = get_node("/root/Node/Main/Player")
	follow_physics()
	player_node.player_hit.connect(_on_player_hit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#if $FlashTimer:
	#	if not $FlashTimer.is_stopped():
	#		$CanvasModulate.set_color(Color(0.980392, 0.921569, 0.843137, 1))
	for CurrentVelocity in [1, 2]:
		if CurrentVelocity == 1:
			velocity_a = linear_velocity
		if CurrentVelocity == 2:
			velocity_b = linear_velocity


func _integrate_forces(_state: PhysicsDirectBodyState2D) -> void:
	if $PoolShotTimer.is_stopped():
		follow_physics()


func follow_physics():
	player_position =  Vector2(player_node.position.x , (player_node.position.y))
	distance = position.distance_to(player_position)
	direction = position.direction_to(player_position)
	
	#print(str(position))
	
	gravity_force = direction * player_gravity
	friction_force = - get_linear_velocity() * coeff_friction

	apply_central_force(gravity_force)
	apply_central_force(friction_force)
	
	if direction.x > 0:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false

func _on_player_hit():
	#if damage_source == self: # toggle to only push back the mob that hurt my boy
	get_pushed()
	go_red()

func get_pushed():
	#print(distance)
	apply_impulse(-direction * knockback_impulse * ((distance + 1) ** -0.5))

func go_red():
	#if $FlashTimer:
	#	$FlashTimer.start()
	#	$CanvasModulate.set_color(Color(0.941176, 0.972549, 1, 1))
	pass

# detects collision with goblins that have been knocked back by a pool shot
func _on_body_entered(body: CollisionObject2D) -> void:
	if body.collision_layer == 2:
		if body.is_pool_shot == true or body.is_first_pool_shot == true:
			# starts timer that disables this goblin's movement for duration, then tells it to stop being a pool shot
			$PoolShotTimer.start()
			# makes this goblin inherit the triggering goblin's velocity (not sure about this line)
			linear_velocity = body.linear_velocity
			body.take_damage(pool_damage)
			if body.is_first_pool_shot == true:
				body.is_first_pool_shot = false
			# allows this goblin to trigger this signal for other goblins
			is_pool_shot = true
		else:
			# applies a backwards 'bounce' when a goblin hits another goblin
			apply_impulse(-position.direction_to(body.position) * (linear_velocity.length() + 100) * 10)



#returns a random key from the goblin_type_dictionary
func pick_random(dictionary: Dictionary):
	var random_goblin_key = dictionary.keys().pick_random()
	return random_goblin_key


func _on_pool_shot_timer_timeout() -> void:
	is_pool_shot = false


func _on_goblin_hurtbox_area_entered(area: Area2D) -> void:
	if area.collision_type == "dart":
		area.queue_free()
		health -= area.damage
		if health <= 0:
			player_node.score += 1
			queue_free()
		else:
			apply_impulse(area.firing_vec * area.knockback_impulse)
			# flash body red using canvasmodulate
	if area.collision_type == "pool_cue":
		area.disable_collision()
		$PoolShotTimer.start()
		linear_velocity = Vector2(0, 0)
		apply_impulse(area.firing_vec * area.knockback_impulse)
		is_first_pool_shot = true
	
	$TextureProgressBar.show()
	$TextureProgressBar.value = health
	


func _on_player_body_entered(body: CharacterBody2D) -> void:
	body.take_damage(attack_damage)
