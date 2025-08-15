extends Node

var crosshair = load("res://art/crosshair64.png")

func _ready():
	Input.set_custom_mouse_cursor(crosshair)
