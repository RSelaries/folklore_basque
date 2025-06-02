extends Area3D


@export var target_camera: Camera3D


func _on_input_event(_camera: Node, event: InputEvent, _event_position: Vector3, _normal: Vector3, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		var mouse_event: InputEventMouseButton = event
		
		if mouse_event.button_index == MOUSE_BUTTON_LEFT and mouse_event.is_pressed():
			target_camera.make_current()
