@tool
class_name CameraPosition
extends Marker3D


signal current_set_to(value)


@export_tool_button("Set Camera to self", "Camera3D") var set_cam: Callable = _set_cam_pos_to_self


@onready var camera_manager: CameraManager = owner.find_child("CameraManager")


var current: bool = false:
	set(value):
		current = value
		current_set_to.emit(value)
		if value and get_children():
			get_children()[0].visible = true
		elif get_children():
			get_children()[0].visible = false

func switch_cam_to_self() -> void:
	_set_cam_pos_to_self()


func _set_cam_pos_to_self() -> void:
	if Engine.is_editor_hint():
		camera_manager = owner.find_child("CameraManager")
	
	camera_manager.switch_cam_to(self)
