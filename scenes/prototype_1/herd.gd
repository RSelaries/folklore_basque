extends Node3D


func _ready() -> void:
	for child: Node3D in get_children():
		child.rotation_degrees.y += RandomNumberGenerator.new().randf_range(-180, 180)
