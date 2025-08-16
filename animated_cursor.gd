extends AnimatedSprite2D

# somehow fixes an error if this is a var instead of just using 0 in the set_custom_mouse_cursor function (???)
var mouse_shape = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Input.set_custom_mouse_cursor(sprite_frames.get_frame_texture(animation, frame), mouse_shape, Vector2(64, 64))
