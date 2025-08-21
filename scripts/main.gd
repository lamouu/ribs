extends Node

@onready var hearts_container = $"../CanvasLayer/HeartsContainer"
@export var goblin_resource: Resource
@export var goblin_base_scene: PackedScene

var player_camera_size
var ham
var rng = RandomNumberGenerator.new()
var mob_spawn_zone
var mob_spawn_location = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SpawnTimer.start()
	$Player.position = $StartPosition.position
	player_camera_size = get_viewport().size
	
	
	hearts_container.setMaxHearts($Player.max_health)
	hearts_container.updateHearts($Player.health)
	$Player.player_really_hit.connect(hearts_container.updateHearts)
	
	#base goblin spawn test
	#var goblin_base = goblin_base_scene.instantiate()
	#add_child(goblin_base)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_spawn_timer_timeout() -> void:
	var mob = goblin_base_scene.instantiate()
	var camera_center = $Player/Camera2D.get_screen_center_position()
	
	mob_spawn_zone = ["below", "above", "left", "right"].pick_random()

	var x_offset = DisplayServer.screen_get_size().x
	var rnd_x_offset = rng.randf_range(- x_offset * 0.5, x_offset * 0.5)
	var y_offset = DisplayServer.screen_get_size().y
	var rnd_y_offset = rng.randf_range(- y_offset * 0.5, y_offset * 0.5)
	
	var map_top_position = $Map.position.y
	var map_bottom_position = map_top_position + $Map.size.y
	var player_camera_top_position = camera_center.y - (player_camera_size.y / 2)
	var player_camera_bottom_position = camera_center.y + (player_camera_size.y / 2)
	var map_leftmost_position = $Map.position.x
	var map_rightmost_position = map_leftmost_position + $Map.size.x
	var player_camera_leftmost_position = camera_center.x - (player_camera_size.x / 2)
	var player_camera_rightmost_position = camera_center.x + (player_camera_size.x / 2)
	
	#gets random x and y coordinates outside of the screen
	var random_above_screen_vertical:float = randf_range((map_top_position) , player_camera_top_position * 1.1)
	var random_below_screen_vertical:float = randf_range((map_bottom_position) , player_camera_bottom_position * 1.1)
	var random_left_of_screen_horizontal: float = randf_range((map_leftmost_position), player_camera_leftmost_position * 1.1)
	var random_right_of_screen_horizontal: float = randf_range((map_rightmost_position), player_camera_rightmost_position * 1.1)
	
	#gets random x and y coordinates from screen size
	var random_y_coordinate = randf_range(map_top_position, map_bottom_position)
	var random_x_coordinate = randf_range(map_leftmost_position, map_rightmost_position)
	
	
	
	#if the spawn location it outside the map, spawns on the opposite side of the screen
	
	
	if mob_spawn_zone == "above":
		if random_above_screen_vertical > player_camera_top_position:
			mob_spawn_zone = "below"
		if random_above_screen_vertical < map_top_position:
			mob_spawn_zone = "below"
	
	if mob_spawn_zone == "below":
		if random_below_screen_vertical < player_camera_bottom_position:
			mob_spawn_zone = "above"
		if random_below_screen_vertical > map_bottom_position:
			mob_spawn_zone = "above"
	
	if mob_spawn_zone == "right":
		if random_right_of_screen_horizontal < player_camera_rightmost_position:
			mob_spawn_zone = "left"
		if random_right_of_screen_horizontal > map_rightmost_position:
			mob_spawn_zone = "left"
	
	if mob_spawn_zone == "left":
		if random_left_of_screen_horizontal > player_camera_leftmost_position:
			mob_spawn_zone = "right"
		if random_left_of_screen_horizontal < map_leftmost_position:
			mob_spawn_zone = "right"
	
	#combines a random x and random y coordinate to create a spawn location
	match mob_spawn_zone:
		"above": mob_spawn_location = Vector2(random_x_coordinate, random_above_screen_vertical)
		"below": mob_spawn_location = Vector2(random_x_coordinate, random_below_screen_vertical)
		"left": mob_spawn_location = Vector2(random_left_of_screen_horizontal, random_y_coordinate)
		"right": mob_spawn_location = Vector2(random_right_of_screen_horizontal, random_y_coordinate)
	
	mob.position = mob_spawn_location
	#print("the x coordinate of the left side of the screen is:", player_camera_leftmost_position)
	#print("the x coordinate of the right side of the screen is:", player_camera_rightmost_position)
	#print("the y coordinate of the top side of the screen is:", player_camera_top_position)
	#print("the y coordinate of the bottom side of the screen is:", player_camera_bottom_position)
	#print("the mob is spawning on the ", mob_spawn_zone, " side of the screen")
	#print("mob spawn coordinates:", mob_spawn_location)
	#print("the left of the map: ", map_leftmost_position)
	#print("the right of the map: ", map_rightmost_position)
	#print("the top of the map: ", map_top_position)
	#print("the bottom of the map: ", map_bottom_position)
	#print(camera_center)
	#print(player_camera_size)
	
	add_child(mob)
	
