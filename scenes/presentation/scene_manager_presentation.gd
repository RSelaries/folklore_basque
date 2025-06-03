extends Node


func switch_to_prototype() -> void:
	for child: Node in get_children():
		child.queue_free()
	
	var prototype_scene: PackedScene = load("uid://78wgp66j7b2c")
