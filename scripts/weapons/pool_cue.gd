extends Area2D

@export var knockback_impulse = 90000

var movement: Vector2
var speed = 5
var char_offset = 5
var firing_vec
var collision_type = "pool_cue"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	firing_vec = (get_viewport().get_mouse_position() - (get_viewport().get_visible_rect().size / 2) + Vector2(0, char_offset)).normalized()
	rotation = firing_vec.angle()
	movement = firing_vec * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position += movement
	

func _on_cue_retract_timer_timeout() -> void:
	queue_free()

func disable_collision():
		$CollisionShape2D.set_deferred("disabled", true)

func _on_cue_extend_timer_timeout() -> void:
	movement = -firing_vec * speed
	$CollisionShape2D.set_deferred("disabled", true)
