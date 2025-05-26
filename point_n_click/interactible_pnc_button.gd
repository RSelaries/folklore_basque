@tool
class_name InteractiblePNCButton
extends Button


@export var interact_script: GDScript
@export var hover_cursor: PointNClick.Cursors = PointNClick.Cursors.INTERACT

var interact_script_inst


func _ready() -> void:
	if interact_script:
		interact_script_inst = interact_script.new()
		if interact_script_inst.has_method("interact"):
			pressed.connect(_interact)
	
	mouse_default_cursor_shape = PointNClick.cursor_names[hover_cursor]
	add_to_group("pnc_highlight_interactions")
	
	# Set the button as transparant
	if not Engine.is_editor_hint():
		add_theme_stylebox_override("focus", StyleBoxEmpty.new())
		add_theme_stylebox_override("hover", StyleBoxEmpty.new())
		add_theme_stylebox_override("normal", StyleBoxEmpty.new())
		add_theme_stylebox_override("pressed", StyleBoxEmpty.new())


func _interact() -> void:
	interact_script_inst.interact()


func self_highlight(highlighted: bool) -> void:
	if highlighted:
		var style_box = StyleBoxFlat.new()
		style_box.bg_color = Color("#699df030")
		style_box.border_color = Color("#699df0")
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
