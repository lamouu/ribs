extends Area2D

@export var speed = 600
@export var weapon_spacing = 60
@export var char_offset = 35


var velocity

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_top_level(true)
	
	var firing_vec = (get_viewport().get_mouse_position() - (get_viewport().get_visible_rect().size / 2) + Vector2(0, char_offset)).normalized()
	global_position = Player.global_position - Vector2(0, char_offset) + firing_vec * weapon_spacing
	rotation = firing_vec.angle()
	velocity = firing_vec * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += velocity * delta
