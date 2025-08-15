extends "res://goblins/goblin_base.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_node = get_node("/root/Main/Player")
	follow_physics()
	player_node.player_hit.connect(_on_player_hit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	follow_physics()
