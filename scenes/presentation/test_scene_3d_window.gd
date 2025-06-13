extends Window


func _unhandled_input(event: InputEvent) -> void:
	if visible:
		if event.is_action_pressed("esc_menu"):
			if get_parent().has_method("hide_window"):
				get_parent().hide_window()
