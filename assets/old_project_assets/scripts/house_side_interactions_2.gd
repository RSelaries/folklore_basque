extends Control


@onready var camera_manager: CameraManager = owner


func _on_house_far_button_pressed() -> void:
	camera_manager._change_location_to("HouseFar")


func _on_handle_button_pressed() -> void:
	print("La porte est vérouillée.")
	%TextManager.show_text("La porte est vérouillée.")
