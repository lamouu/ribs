extends Area2D

@export var knockback_impulse = 20000

var movement: Vector2
var speed = 15
var char_offset = 75
var weapon_spacing = 125
var firing_vec
var collision_type = "pool_cue"
var rotates_with_mouse = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position -= Vector2(0, 50)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if rotates_with_mouse == true:
		rotate_to_mouse()
		if Input.is_action_just_released("special_attack"):
			speed = 20
			movement = firing_vec * speed
			rotates_with_mouse = false
			$CollisionShape2D.set_deferred("disabled", false)
			$CueExtendTimer.start()

	if not $CueExtendTimer.is_stopped():
		position += movement
	#if is_firing == false:
	#	if is_returning == false:
	#		#position -= Vector2(0, char_offset) - firing_vec * weapon_spacing
	#		firing_vec = (get_viewport().get_mouse_position() - (get_viewport().get_visible_rect().size / 2) + Vector2(0, char_offset)).normalized()
	#		rotation = firing_vec.angle()
	
	
	#if is_firing == true:
	#	global_position += firing_vec * movement
	#if is_returning == true:
	#	global_position += firing_vec * movement
		
	
# Called until right click is let go, rotates the pool cue towards the mouse and pulls it backwards into position
func rotate_to_mouse():
	firing_vec = ((global_position - position) - Vector2(0, 70)).direction_to(get_global_mouse_position())
	print(firing_vec)
	rotation = firing_vec.angle()
	position = (firing_vec * weapon_spacing) - Vector2(0, 70)
	if visible == false:
		visible = true
	if not $CueReadyTimer.is_stopped():
		weapon_spacing -= 2

func _on_cue_retract_timer_timeout() -> void:
	queue_free()

func disable_collision():
		$CollisionShape2D.set_deferred("disabled", true)

func _on_cue_extend_timer_timeout() -> void:
	await get_tree().create_timer(0.2).timeout
	queue_free()
	$CollisionShape2D.set_deferred("disabled", true)
	
