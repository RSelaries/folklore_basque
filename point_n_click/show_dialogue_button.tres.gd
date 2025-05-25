extends Button


@export var message_to_show: DialogueResource
@export var invisible: bool = true


func _ready() -> void:
	add_to_group("pnc_highlight_interactions")
	
	pressed.connect(func():
		if message_to_show:
			DialogueManager.show_dialogue_balloon(message_to_show) )
	
	if invisible:
		add_theme_stylebox_override("normal", StyleBoxEmpty.new())
		add_theme_stylebox_override("focus", StyleBoxEmpty.new())
		add_theme_stylebox_override("hover", StyleBoxEmpty.new())
		add_theme_stylebox_override("hover_pressed", StyleBoxEmpty.new())
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
