extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Input.set_custom_mouse_cursor(sprite_frames.get_frame_texture(animation, frame), 0, Vector2(64, 64))
