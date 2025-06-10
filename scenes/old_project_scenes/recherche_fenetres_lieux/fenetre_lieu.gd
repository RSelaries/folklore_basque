class_name PlaceWindow
extends Window


func _ready() -> void:
	var random_x = randi_range(100, 1920 - size.x - 100)
	var random_y = randi_range(100, 1080 - size.y - 100)
	position = Vector2(random_x, random_y)
	unresizable = true
	
	title = name
	
	visible = false
	get_parent().connect("visibility_changed", func(): visible = get_parent().visible)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("esc_menu"):
		if get_parent() and "hide_lieux" in get_parent():
			get_parent().hide_lieux.call()
