extends Control


@export var start_scene: PackedScene


func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_button_pressed() -> void:
	$AnimationPlayer.play("fade")


func _change_scene() -> void:
	get_tree().change_scene_to_packed(start_scene)
