extends Button


const HIGLIGHT: StyleBoxFlat = preload("uid://dplcm1pfp8to5")


func _ready() -> void:
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND


func _highlighting() -> void:
	self.add_theme_stylebox_override("normal", HIGLIGHT)
	self.add_theme_stylebox_override("hover", HIGLIGHT)
	self.add_theme_stylebox_override("focus", HIGLIGHT)


func _stop_highlight() -> void:
	self.add_theme_stylebox_override("normal", StyleBoxEmpty.new())
	self.add_theme_stylebox_override("hover", StyleBoxEmpty.new())
	self.add_theme_stylebox_override("focus", StyleBoxEmpty.new())


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("reveal_buttons"):
		_highlighting()
	elif event.is_action_released("reveal_buttons"):
		_stop_highlight()
