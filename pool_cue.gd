extends Area2D

@export var knockback_impulse = 90000

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

	if rotates_with_mouse == false:
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
		
	

func rotate_to_mouse():
	firing_vec = (get_viewport().get_mouse_position() - (get_viewport().get_visible_rect().size / 2) + Vector2(0, char_offset)).normalized()
	rotation = firing_vec.angle()
	position = (firing_vec * weapon_spacing) - Vector2(0, 70)
	if visible == false:
		visible = true

func _on_cue_retract_timer_timeout() -> void:
	queue_free()

func disable_collision():
		$CollisionShape2D.set_deferred("disabled", true)

func _on_cue_extend_timer_timeout() -> void:
	$CueRetractTimer.start()
	speed = 3
	movement = -firing_vec * speed
	$CollisionShape2D.set_deferred("disabled", true)
	
