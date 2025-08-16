extends Node

@export var goblin_base_scene: PackedScene
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SpawnTimer.start()
	$Player.position = $StartPosition.position
	
	#base goblin spawn test
	#var goblin_base = goblin_base_scene.instantiate()
	#add_child(goblin_base)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_spawn_timer_timeout() -> void:
	var mob = goblin_base_scene.instantiate()
	
	var mob_spawn_location
	var mob_spawn_direction = ["up", "down", "left", "right"].pick_random()

	var x_offset = DisplayServer.screen_get_size().x
	var rnd_x_offset = rng.randf_range(- x_offset * 0.5, x_offset * 0.5)
	var y_offset = DisplayServer.screen_get_size().y
	var rnd_y_offset = rng.randf_range(- y_offset * 0.5, y_offset * 0.5)
	
	if mob_spawn_direction == "up":
		mob_spawn_location = $Player.position + Vector2(rnd_x_offset, -y_offset)
	elif mob_spawn_direction == "down":
		mob_spawn_location = $Player.position + Vector2(rnd_x_offset, y_offset)
	elif mob_spawn_direction == "left":
		mob_spawn_location = $Player.position + Vector2(-x_offset, rnd_y_offset)
	elif mob_spawn_direction == "right":
		mob_spawn_location = $Player.position + Vector2(x_offset, rnd_y_offset)

	mob.position = mob_spawn_location
	
	
	add_child(mob)
	
