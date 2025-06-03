extends Control


@onready var camera_manager: OldCameraManager = owner


func _on_house_far_button_pressed() -> void:
	camera_manager._change_location_to("HouseFar")


func _on_handle_button_pressed() -> void:
	if %InventoryManager.items.has("ClePorte"):
		%InventoryManager.remove_item("ClePorte")
		%Main.find_child("AnimationPlayer").play("DoorOpening")
	else:
		print("La porte est vérouillée.")
		%TextManager.show_text("La porte est vérouillée.")
