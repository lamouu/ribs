extends Node

func _ready() -> void:
	$CanvasLayer/GnomeShop.hide()

func _input(event):
	if event.is_action_pressed("debug_4"):
		if get_tree().paused == true:
			get_tree().paused = false
			
			hide_shop()
			
		else:
			get_tree().paused = true

			show_shop()

func show_shop():
	$CanvasLayer/GnomeShop.show()
	$CanvasLayer/TextureProgressBar.hide()
	$CanvasLayer/HeartsContainer.hide()

func hide_shop():
	$CanvasLayer/GnomeShop.hide()
	$CanvasLayer/TextureProgressBar.show()
	$CanvasLayer/HeartsContainer.show()
