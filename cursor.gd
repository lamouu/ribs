extends Node

var crosshair = load("res://art/crosshair.png")

func _ready():
	Input.set_custom_mouse_cursor(crosshair)
