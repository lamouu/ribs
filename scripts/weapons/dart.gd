extends Area2D

@export var speed = 600
@export var dart_damage = 50
@export var weapon_spacing = 60
@export var char_offset = 80
@export var knockback_impulse = 30000

var collision_type = "dart"
var velocity
var player_node
var firing_vec
var damage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_top_level(true)
	player_node = get_node("../../Player")
	
	global_position = player_node.position - Vector2(0, char_offset)
	firing_vec = global_position.direction_to(get_global_mouse_position())
	
	rotation = firing_vec.angle()
	velocity = firing_vec * speed
	position += firing_vec * weapon_spacing

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	damage = dart_damage * player_node.damage
	global_position += velocity * delta
