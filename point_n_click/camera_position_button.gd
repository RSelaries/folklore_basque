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

@export var hover_cursor: PointNClick.Cursors = PointNClick.Cursors.INTERACT

@onready var camera_manager: CameraManager = owner.find_child("CameraManager")


func _ready() -> void:
	pressed.connect(_on_pressed)
	mouse_default_cursor_shape = PointNClick.cursor_names[hover_cursor]
	
	add_to_group("pnc_highlight_interactions")
	
	if links_to:
		name = "To" + links_to.name
	
	if not Engine.is_editor_hint():
		add_theme_stylebox_override("focus", StyleBoxEmpty.new())
		add_theme_stylebox_override("hover", StyleBoxEmpty.new())
		add_theme_stylebox_override("normal", StyleBoxEmpty.new())
		add_theme_stylebox_override("pressed", StyleBoxEmpty.new())


func self_highlight(highlighted: bool) -> void:
	if highlighted:
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color("#fcba0330")
		style_box.border_color = Color("#fcba03")
		style_box.set_corner_radius_all(5)
		style_box.set_border_width_all(2)
		
		add_theme_stylebox_override("focus", style_box)
		add_theme_stylebox_override("hover", style_box)
		add_theme_stylebox_override("normal", style_box)
		add_theme_stylebox_override("pressed", style_box)
	
	else:
		add_theme_stylebox_override("focus", StyleBoxEmpty.new())
		add_theme_stylebox_override("hover", StyleBoxEmpty.new())
		add_theme_stylebox_override("normal", StyleBoxEmpty.new())
		add_theme_stylebox_override("pressed", StyleBoxEmpty.new())


func _on_pressed() -> void:
	if links_to:
		camera_manager.switch_cam_to(links_to)
