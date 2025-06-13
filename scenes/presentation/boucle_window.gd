extends Window


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if visible:
		if event.is_action_pressed("esc_menu"):
			if get_parent() and get_parent().has_method("hide_window"):
				get_parent().hide_window()
		set_input_as_handled()
