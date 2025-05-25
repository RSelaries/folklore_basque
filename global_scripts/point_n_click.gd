@tool
extends Node


const cursor_default = preload("uid://bpvit7ir4jdgl")
const arrow_up = preload("uid://djsb7foy6wqnk")
const arrow_down = preload("uid://cu0pa01bakcyx")
const arrow_left = preload("uid://bquwq4vk4wvhw")
const arrow_right = preload("uid://b5oo8j71pnox3")
const cursor_talk = preload("uid://cw0vx6y4qorae")


enum Cursors {
	DEFAULT = 0,
	INTERACT = 1,
	ARROW_UP = 2,
	ARROW_DOWN = 3,
	ARROW_LEFT = 4,
	ARROW_RIGHT = 5,
	CURSOR_TALK = 6,
}
var cursor_names: Dictionary[Cursors, Control.CursorShape] = {
	Cursors.DEFAULT : Control.CURSOR_ARROW,
	Cursors.INTERACT : Control.CURSOR_POINTING_HAND,
	Cursors.ARROW_UP : Control.CURSOR_CROSS,
	Cursors.ARROW_DOWN : Control.CURSOR_DRAG,
	Cursors.ARROW_LEFT : Control.CURSOR_BDIAGSIZE,
	Cursors.ARROW_RIGHT : Control.CURSOR_FORBIDDEN,
	Cursors.CURSOR_TALK : Control.CURSOR_BUSY,
}


func _ready() -> void:
	_init_cursor_shapes()


func _init_cursor_shapes() -> void:
	# Default
	Input.set_custom_mouse_cursor(cursor_default, Input.CURSOR_ARROW, Vector2(2,2))
	
	# Talk
	Input.set_custom_mouse_cursor(cursor_talk, Input.CURSOR_BUSY, Vector2(12, 12))
	
	# Arrows
	Input.set_custom_mouse_cursor(arrow_up, Input.CURSOR_CROSS, Vector2(16, 16))
	Input.set_custom_mouse_cursor(arrow_down, Input.CURSOR_DRAG, Vector2(16, 16))
	Input.set_custom_mouse_cursor(arrow_left, Input.CURSOR_BDIAGSIZE, Vector2(16, 16))
	Input.set_custom_mouse_cursor(arrow_right, Input.CURSOR_FORBIDDEN, Vector2(16, 16))


func _unhandled_input(event: InputEvent) -> void:
	if Engine.is_editor_hint():
		return
	
	if event.is_action_pressed("pnc_highlight_interactions"):
		get_tree().call_group("pnc_highlight_interactions", "self_highlight", true)
	elif event.is_action_released("pnc_highlight_interactions"):
		get_tree().call_group("pnc_highlight_interactions", "self_highlight", false)
