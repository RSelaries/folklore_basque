@tool
class_name CameraManager
extends Node


@onready var cam_manager_sub_viewport: SubViewport = $CameraPreview/CamManagerSubViewport
@onready var start: CameraPosition = $CameraPreview/CamManagerSubViewport/Start
@onready var gamma_rect: ColorRect = %Gamma

var gamma_shader: ShaderMaterial


var pc_camera: Camera3D:
	get():
		return find_child("PCCamera")


func _ready() -> void:
	gamma_shader = gamma_rect.get_material()
	switch_cam_to(start, false)


func switch_cam_to(cam_pos: CameraPosition, use_transition: bool = false) -> void:
	if use_transition:
		_transition_gamma()
		await get_tree().create_timer(0.25).timeout
	
	pc_camera.global_position = cam_pos.global_position
	pc_camera.global_rotation = cam_pos.global_rotation
	
	for sub_child in cam_manager_sub_viewport.get_children():
		if sub_child is CameraPosition:
			sub_child.current = false
		if sub_child == cam_pos:
			sub_child.current = true


func _transition_gamma() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(gamma_shader, "shader_parameter/gamma", 0.0, 0.2)
	tween.tween_property(gamma_shader, "shader_parameter/gamma", 0.0, 0.1)
	tween.tween_property(gamma_shader, "shader_parameter/gamma", 1.0, 0.2)
