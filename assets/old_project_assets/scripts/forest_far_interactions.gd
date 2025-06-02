extends Control


@onready var camera_manager: CameraManager = owner


func _on_forest_closer_button_pressed() -> void:
	camera_manager._change_location_to("ForestCloser")


func _on_forest_closest_button_pressed() -> void:
	camera_manager._change_location_to("ForestClosest")


func _on_house_far_button_pressed() -> void:
	camera_manager._change_location_to("HouseFar")
