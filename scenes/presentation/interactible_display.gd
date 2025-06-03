extends Area3D


@onready var display: Sprite3D = %Display
@onready var canvas_group: CanvasGroup = %CanvasGroup


var focused: bool = true:
	set(value):
		focused = value
		if value:
			canvas_group.material.set_shader_parameter("width", 10.0)
			PlayerState.interaction = PlayerState.Interactions.USE
		else:
			canvas_group.material.set_shader_parameter("width", 0.0)


func _ready() -> void:
	canvas_group.material.set_shader_parameter("width", 0.0)


func interact() -> void:
	OS.execute("E://Godot/Projects/folklore_basque/builds/other_projects/dream_scape_awake.exe", [])
