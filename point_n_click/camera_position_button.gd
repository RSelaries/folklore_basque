@tool
class_name CameraPositionButton
extends Button


@export var links_to: CameraPosition:
	set(value):
		links_to = value
		if value:
			name = "To" + value.name
		else:
			name = "ToNowhere"

@onready var camera_manager: CameraManager = owner.find_child("CameraManager")


func _ready() -> void:
	if links_to:
		name = "To" + links_to.name
	
	pressed.connect(_on_pressed)
	mouse_default_cursor_shape = Control.CURSOR_POINTING_HAND
	
	if not Engine.is_editor_hint():
		add_theme_stylebox_override("focus", StyleBoxEmpty.new())
		add_theme_stylebox_override("hover", StyleBoxEmpty.new())
		add_theme_stylebox_override("normal", StyleBoxEmpty.new())
		add_theme_stylebox_override("pressed", StyleBoxEmpty.new())


func _on_pressed() -> void:
	if links_to:
		camera_manager.switch_cam_to(links_to)
