@tool
class_name Utils
extends Node


@export var camera_name: String
@export_tool_button("Switch camera to ^") var target = switch_camera_to

@export var location_name: String
@export_tool_button("Switch location to ^") var switch_location_to_call = switch_location_to


func switch_camera_to() -> void:
	%Main.find_child(camera_name).make_current()
	camera_name = ""


func switch_location_to() -> void:
	owner._change_location_to(location_name)
