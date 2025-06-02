extends Node


@export var resolved_window_scene: PackedScene


var is_resolved: bool = false:
	get():
		if is_resolved:
			return is_resolved
		else:
			return test_is_resolved()
var do_test: bool = true


func _ready() -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	get_window().size = Vector2(1, 1)
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)


func _process(_delta: float) -> void:
	if is_resolved and do_test:
		for child in get_children():
			child.queue_free()
		
		add_child(resolved_window_scene.instantiate())
		do_test = false
		get_tree().create_timer(2).timeout.connect(_next_scene)


func _next_scene() -> void:
	get_tree().change_scene_to_file("uid://d2deerth84jc3")


func test_is_resolved() -> bool:
	for child: PuzzleWindow in get_children():
		if not child.resolved:
			is_resolved = false
			return false
	is_resolved = true
	return true
