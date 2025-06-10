extends Window


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc_menu"):
		if get_parent() and get_parent().has_method("hide_pnc"):
			get_parent().hide_pnc()
