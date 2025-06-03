extends Control


@export var croix_basque: PackedScene

@onready var camera_manager: OldCameraManager = owner


func _on_cross_pick_button_pressed() -> void:
	%TextManager.show_text("Vous avez récupéré une croix basque !", 1.5)
	%InventoryManager.add_item("CroixBasque", croix_basque)
	$CrossPickButton.hide()
	%Main.find_child("CrossDecal", true).visible = false


func _on_house_side_button_pressed() -> void:
	camera_manager._change_location_to("HouseSide")
