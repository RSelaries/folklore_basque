extends Node3D


@onready var color_rect: ColorRect = %ColorRect


func _ready() -> void:
	get_window().transparent_bg = false


func set_shader(value: bool) -> void:
	color_rect.material.set_shader_parameter("active", value)
