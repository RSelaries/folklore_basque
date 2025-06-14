extends Window


func _unhandled_input(event: InputEvent) -> void:
	if visible:
		if event.is_action_pressed("esc_menu"):
			if get_parent().has_method("hide_window"):
				get_parent().hide_window()


func set_shader(value: bool) -> void:
	if get_child(0).has_method("set_shader"):
		get_child(0).set_shader(value)
