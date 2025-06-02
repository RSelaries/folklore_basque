extends Control


@export var items: Array[String] = []


func add_item(item_name:String, item_scene: PackedScene) -> void:
	items.append(item_name)
	
	var new_item_scene: Control = item_scene.instantiate()
	if "inventory_manager" in new_item_scene:
		new_item_scene.inventory_manager = self
	if  "text_manager" in new_item_scene:
		new_item_scene.text_manager = owner.find_child("TextManager")
	$MarginContainer/InventoryGrid.add_child(new_item_scene)


func remove_item(item_name: String) -> void:
	items.remove_at(items.find(item_name))
	for child in $MarginContainer/InventoryGrid.get_children():
		if child.name == item_name:
			child.queue_free()
