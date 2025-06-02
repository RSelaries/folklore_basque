extends Control


func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	get_window().size = Vector2(630, 460)
	get_window().unresizable = true
	get_window().always_on_top = true
	get_window().title = "Inventaire"
	
	%Inventory.resized.connect(_resize_window)


func _resize_window() -> void:
	get_window().size = %Inventory.size
