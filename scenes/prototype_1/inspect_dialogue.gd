class_name InspectDialogueButton
extends Button


@export var dialogue: DialogueResource
@export var hover_cursor: PointNClick.Cursors = PointNClick.Cursors.INTERACT


func _ready() -> void:
	pressed.connect(_on_pressed)
	
	mouse_default_cursor_shape = PointNClick.cursor_names[hover_cursor]
	add_to_group("pnc_highlight_interactions")
	
	# Set the button as transparant
	if not Engine.is_editor_hint():
		add_theme_stylebox_override("focus", StyleBoxEmpty.new())
		add_theme_stylebox_override("hover", StyleBoxEmpty.new())
		add_theme_stylebox_override("normal", StyleBoxEmpty.new())
		add_theme_stylebox_override("pressed", StyleBoxEmpty.new())


func _on_pressed() -> void:
	DialogueManager.show_dialogue_balloon(dialogue)


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
