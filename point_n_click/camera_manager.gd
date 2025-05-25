@tool
class_name CameraManager
extends Node


@export_enum("fade_in_out:0", "tween_blur:1", "none:2") var transition_type: int = 2


@onready var cam_manager_sub_viewport: SubViewport = %CamManagerSubViewport
@onready var start: CameraPosition = %Start
@onready var blur_rect: ColorRect = %BlurRect
@onready var fade_in_out: ColorRect = %FadeInOut


var pc_camera: Camera3D:
	get():
		return find_child("PCCamera")


func _ready() -> void:
	switch_cam_to(start, false)


func switch_cam_to(cam_pos: CameraPosition, use_transition: bool = true) -> void:
	#if use_transition:
		#_transition_fade_in_out()
		#await get_tree().create_timer(0.15).timeout
	
	if use_transition and transition_type == 1:
		_transition_blur()
		
		var tween: Tween = get_tree().create_tween()
		tween.set_parallel(true)
		tween.tween_property(pc_camera, "global_position", cam_pos.global_position, 0.3)
		tween.tween_property(pc_camera, "global_rotation", cam_pos.global_rotation, 0.3)
	else:
		if use_transition and transition_type == 0:
			_transition_fade_in_out()
			await get_tree().create_timer(0.15).timeout
	
		pc_camera.global_position = cam_pos.global_position
		pc_camera.global_rotation = cam_pos.global_rotation
	
	for sub_child in cam_manager_sub_viewport.get_children():
		if sub_child is CameraPosition:
			sub_child.current = false
		if sub_child == cam_pos:
			sub_child.current = true


func _transition_blur() -> void:
	var blur_shader: ShaderMaterial = blur_rect.material
	var tween = get_tree().create_tween()
	
	tween.tween_property(blur_shader, "shader_parameter/blur_power", 0.031, 0.1)
	tween.tween_property(blur_shader, "shader_parameter/blur_power", 0.031, 0.1)
	tween.tween_property(blur_shader, "shader_parameter/blur_power", 0, 0.1)


func _transition_fade_in_out() -> void:
	var tween = get_tree().create_tween()
	
	tween.tween_property(fade_in_out, "color", Color("#000f"), 0.1)
	tween.tween_property(fade_in_out, "color", Color("#000f"), 0.1)
	tween.tween_property(fade_in_out, "color", Color("#0000"), 0.1)
