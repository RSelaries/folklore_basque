@tool
extends Path3D


var follow_path_lamina: PackedScene = preload("uid://qpu2bnf7ibj3")


func _ready() -> void:
	for i in range(37):
		var new_lamina: PathFollow3D = follow_path_lamina.instantiate()
		add_child(new_lamina)
		new_lamina.progress = i * 1.4816
