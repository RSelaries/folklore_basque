extends Control


@export var prot_scene: PackedScene


func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	pass


func _on_button_pressed() -> void:
	$AnimationPlayer.play("fade")


func _change_scene() -> void:
	get_tree().change_scene_to_file("uid://cf6ok0syg18r")
