extends Button


@export var message_to_show: DialogueResource
@export var invisible: bool = true


func _ready() -> void:
	pressed.connect(func():
		if message_to_show:
			DialogueManager.show_dialogue_balloon(message_to_show) )
	
	if invisible:
		add_theme_stylebox_override("normal", StyleBoxEmpty.new())
		add_theme_stylebox_override("focus", StyleBoxEmpty.new())
		add_theme_stylebox_override("hover", StyleBoxEmpty.new())
		add_theme_stylebox_override("hover_pressed", StyleBoxEmpty.new())
		add_theme_stylebox_override("pressed", StyleBoxEmpty.new())
