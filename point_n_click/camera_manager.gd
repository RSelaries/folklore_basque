@tool
class_name CameraManager
extends Node


@onready var cam_manager_sub_viewport: SubViewport = $CameraPreview/CamManagerSubViewport
@onready var start: CameraPosition = $CameraPreview/CamManagerSubViewport/Start


var pc_camera: Camera3D:
	get():
		return find_child("PCCamera")


func _ready() -> void:
	switch_cam_to(start)


func switch_cam_to(cam_pos: CameraPosition) -> void:
	pc_camera.global_position = cam_pos.global_position
	pc_camera.global_rotation = cam_pos.global_rotation
	
	for sub_child in cam_manager_sub_viewport.get_children():
		if sub_child is CameraPosition:
			sub_child.current = false
		if sub_child == cam_pos:
			sub_child.current = true
