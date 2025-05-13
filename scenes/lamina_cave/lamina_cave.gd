@tool
extends Node3D

@onready var laminak_path: Path3D = %LaminakPath
@onready var path_follow_lamina: PackedScene = preload("uid://qpu2bnf7ibj3")


func _ready() -> void:
	var possible_nbr_of_laminak: int = int(round(laminak_path.curve.get_baked_length() / 1.5))
	
	for i: int in range(possible_nbr_of_laminak):
		var new_lamina: PathFollow3D = path_follow_lamina.instantiate()
		new_lamina.progress = i * 1.5
		laminak_path.add_child(new_lamina)
