extends Node3D


func _ready() -> void:
	visibility_changed.connect(_on_visibility_changed)
	_on_visibility_changed()


func _on_visibility_changed() -> void:
	if visible:
		if $StaticBody3D:
			for collision in $StaticBody3D.get_children():
				collision.set_deferred("disabled", false)
	else:
		if $StaticBody3D:
			for collision in $StaticBody3D.get_children():
				collision.set_deferred("disabled", true)
