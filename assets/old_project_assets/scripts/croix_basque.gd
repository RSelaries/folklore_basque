extends Control


@export var cle_scene: PackedScene

var inventory_manager: Node
var text_manager: Node


func _on_button_pressed() -> void:
	text_manager.show_text("Vous trouvez une clef derrière la croix.")
	inventory_manager.add_item("ClePorte", cle_scene)
	inventory_manager.remove_item("CroixBasque")
