@tool
class_name Scene3D
extends Node3D


@export var in_engine_no_fog: bool = true:
	set(value):
		in_engine_no_fog = value
		if value:
			%WorldEnvironment.environment.fog_enabled = false
		else:
			%WorldEnvironment.environment.fog_enabled = true


@export var cameras: Array[Camera3D]:
	set(value):
		_update_cameras(true)


var previous_children: Array[Node]


func _ready() -> void:
	cameras.clear()
	for child in get_children():
		if child is Camera3D:
			cameras.append(child)
	
	%WorldEnvironment.environment.fog_enabled = true


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		_update_cameras()
		if in_engine_no_fog and %WorldEnvironment.environment.fog_enabled:
			%WorldEnvironment.environment.fog_enabled = false


func _update_cameras(force: bool = false) -> void:
	if get_children() == previous_children and !force:
		return
	else:
		previous_children = get_children()
	
	cameras.clear()
	for child in get_children():
		if child is Camera3D:
			cameras.append(child)


func change_to_mini_games() -> void:
	get_tree().change_scene_to_file("uid://mdp0jea0y75i")
