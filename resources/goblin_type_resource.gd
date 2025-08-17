extends Resource
class_name goblin_type

@export var basic_texture: Texture
@export var naked_texture: Texture
@export var pirate_texture: Texture
@export var rock_texture: Texture
var type
var texture
var speed
var damage

var types: Array = ["basic", "naked", "pirate", "rock"]

func get_random_type():
	type = types.pick_random()
	
	match type:
		"basic":
			texture = basic_texture
			# set speed and damage of basic goblin here
		"naked":
			texture = naked_texture
			# set speed and damage of naked goblin here
		"pirate":
			texture = pirate_texture
			# set speed and damage of pirate goblin here
		"rock":
			texture = rock_texture
			# set speed and damage of rock goblin here
