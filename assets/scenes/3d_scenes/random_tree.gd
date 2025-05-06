@tool
extends StaticBody3D


@export_tool_button("Change mesh", "MeshInstance3D") var change_mesh_callable = change_mesh

@export var tree_meshes: Array[Mesh]

@onready var mesh_instance_3d: MeshInstance3D = %MeshInstance3D


func change_mesh() -> void:
	if tree_meshes.size() > 0:
		var rdm_number: int = Global.rng.randi_range(0, tree_meshes.size() - 1)
		
		mesh_instance_3d.mesh = tree_meshes[rdm_number]
	else:
		print("Error, no mesh found.")


func _ready() -> void:
	change_mesh()
