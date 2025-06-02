class_name PlaceWindow
extends Window


func _ready() -> void:
	var random_x = randi_range(100, 1920 - size.x - 100)
	var random_y = randi_range(100, 1080 - size.y - 100)
	position = Vector2(random_x, random_y)
	unresizable = true
	
	title = name
	visible = true
	
