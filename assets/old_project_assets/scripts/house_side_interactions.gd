extends Control


@onready var camera_manager: CameraManager = owner


func _on_house_door_button_pressed() -> void:
	camera_manager._change_location_to("HouseDoor")


func _on_house_far_button_pressed() -> void:
	camera_manager._change_location_to("HouseFar")


func _on_house_cross_button_pressed() -> void:
	camera_manager._change_location_to("HouseCross")
