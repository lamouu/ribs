extends "res://goblins/goblin_base.gd"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_node = get_node("/root/Main/Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _integrate_forces(state):
	follow_physics(state)
