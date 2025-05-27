extends CanvasLayer


func _ready() -> void:
	visible = false


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc_menu"):
		visible = !visible
		get_viewport().set_input_as_handled()


func _on_resume_button_pressed() -> void:
	visible = false


func _on_quit_button_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
