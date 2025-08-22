extends Area2D

@export var speed = 600
@export var damage = 50
@export var weapon_spacing = 60
@export var char_offset = 80
@export var knockback_impulse = 30000

var collision_type = "dart"
var velocity
var player_node
var firing_vec

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_top_level(true)
	player_node = get_node("../../Player")
	
	firing_vec = (get_viewport().get_mouse_position() - (get_viewport().get_visible_rect().size / 2) + Vector2(0, char_offset)).normalized()
	global_position = player_node.position - Vector2(0, char_offset) + firing_vec * weapon_spacing
	rotation = firing_vec.angle()
	velocity = firing_vec * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += velocity * delta
