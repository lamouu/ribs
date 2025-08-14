extends Area2D

signal mob_hit
signal goblin_death

@export var speed = 600
@export var damage = 50
@export var weapon_spacing = 60
@export var char_offset = 35

var velocity
var player_node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_as_top_level(true)
	player_node = get_node("../../Player")
	
	var firing_vec = (get_viewport().get_mouse_position() - (get_viewport().get_visible_rect().size / 2) + Vector2(0, char_offset)).normalized()
	global_position = player_node.position - Vector2(0, char_offset) + firing_vec * weapon_spacing
	rotation = firing_vec.angle()
	velocity = firing_vec * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += velocity * delta


func _on_body_entered(body: RigidBody2D) -> void:

	if body.mob_type == "goblin":
		print("goblin hit")
		goblin_hit(body)

func goblin_hit(body):
	queue_free()
	
	body.health -= damage
	if body.health <= 0:
		player_node.score += 1
		body.free()
	
