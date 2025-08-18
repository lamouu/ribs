extends Node

@export var goblin_resource: Resource
@export var goblin_base_scene: PackedScene
var player_camera
var rng = RandomNumberGenerator.new()
var spawn_buffer_y: float
var spawn_buffer_x: float
var mob_spawn_vertical
var mob_spawn_horizontal
var mob_spawn_location = Vector2(0, 0)
var camera_top_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SpawnTimer.start()
	$Player.position = $StartPosition.position
	player_camera = get_viewport()
	spawn_buffer_y = (player_camera.size.y / 2)
	spawn_buffer_x = (player_camera.size.x / 2)
	
	#base goblin spawn test
	#var goblin_base = goblin_base_scene.instantiate()
	#add_child(goblin_base)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_spawn_timer_timeout() -> void:
	var mob = goblin_base_scene.instantiate()
	var camera_center = $Player/Camera2D.get_screen_center_position()
	
	mob_spawn_vertical = ["below", "above"].pick_random()
	mob_spawn_horizontal = ["left", "right"].pick_random()

	var x_offset = DisplayServer.screen_get_size().x
	var rnd_x_offset = rng.randf_range(- x_offset * 0.5, x_offset * 0.5)
	var y_offset = DisplayServer.screen_get_size().y
	var rnd_y_offset = rng.randf_range(- y_offset * 0.5, y_offset * 0.5)
	
	var map_top_position = $Map.position.y
	var map_bottom_position = map_top_position + $Map.size.y
	var player_camera_top_position = camera_center.y - (player_camera.size.y / 2)
	var player_camera_bottom_position = camera_center.y + (player_camera.size.y / 2)
	var map_leftmost_position = $Map.position.x
	var map_rightmost_position = map_leftmost_position + $Map.size.x
	var player_camera_leftmost_position = camera_center.x - (player_camera.size.x / 2)
	var player_camera_rightmost_position = camera_center.x + (player_camera.size.x / 2)
	
	var random_above_screen_vertical:float = randf_range((map_top_position + spawn_buffer_y) , player_camera_top_position)
	var random_below_screen_vertical:float = randf_range((map_bottom_position - spawn_buffer_y) , player_camera_bottom_position)
	var random_left_of_screen_horizontal: float = randf_range((map_leftmost_position + spawn_buffer_x), player_camera_leftmost_position)
	var random_right_of_screen_horizontal: float = randf_range((map_rightmost_position - spawn_buffer_x), player_camera_rightmost_position)
	
	#if mob_spawn_direction == "up":
	#	mob_spawn_location = $Player.position + Vector2(rnd_x_offset, -y_offset)
	#elif mob_spawn_direction == "down":
	#	mob_spawn_location = $Player.position + Vector2(rnd_x_offset, y_offset)
	#elif mob_spawn_direction == "left":
	#	mob_spawn_location = $Player.position + Vector2(-x_offset, rnd_y_offset)
	#elif mob_spawn_direction == "right":
	#	mob_spawn_location = $Player.position + Vector2(x_offset, rnd_y_offset)
	
	if random_above_screen_vertical <= map_top_position:
		mob_spawn_vertical = "below"
	elif random_below_screen_vertical >= map_bottom_position:
		mob_spawn_vertical = "above"
	
	if random_left_of_screen_horizontal <= map_leftmost_position:
		mob_spawn_horizontal = "right"
	elif random_right_of_screen_horizontal >= map_rightmost_position:
		mob_spawn_horizontal = "left"
	
	match mob_spawn_vertical:
		"above": mob_spawn_location.y = random_above_screen_vertical
		"below": mob_spawn_location.y = random_below_screen_vertical
	match mob_spawn_horizontal:
		"left": mob_spawn_location.x = random_left_of_screen_horizontal
		"right": mob_spawn_location.x = random_right_of_screen_horizontal
	#var mob_spawn_location = Vector2(vertical_spawn_zone, horizontal_spawn_zone)
	mob.position = mob_spawn_location
	print(player_camera_leftmost_position)
	print(player_camera_rightmost_position)
	print(player_camera_top_position)
	print(player_camera_bottom_position)
	print(mob_spawn_location)
	add_child(mob)
	
