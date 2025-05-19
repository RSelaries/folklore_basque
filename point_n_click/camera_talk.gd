@tool
class_name CameraTalk
extends CameraPosition


@export var back_to: CameraPosition
@export var dialogue: DialogueResource


func _ready() -> void:
	current_set_to.connect(_on_current_set_to)


func _on_current_set_to(value) -> void:
	if value:
		var balloon_scene = DialogueManager.show_dialogue_balloon(dialogue)
		balloon_scene.tree_exited.connect(_on_dialogue_ended)


func _on_dialogue_ended() -> void:
	camera_manager.switch_cam_to(back_to)
