extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visibility_changed.connect(func():
		if visible:
			get_window().mode = Window.MODE_WINDOWED
			get_window().size = Vector2(2, 2)
			get_window().mode = Window.MODE_FULLSCREEN
	)
