extends Node3D


@onready var terrain_3d: Terrain3D = %Terrain3D
@onready var pc_camera: Camera3D = %PCCamera


func _ready() -> void:
	terrain_3d.set_camera(pc_camera)
