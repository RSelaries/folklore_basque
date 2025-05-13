extends Node3D


@export var character_timing: float = 0.04
@export var dialogue_skip_time: float = 1.0

@onready var dialogue_label: RichTextLabel = %DialogueLabel
@onready var dialogue_skip_timer: Timer = %DialogueSkipTimer

var current_diag_line_index: int = -1
var text_loading: bool = false
var dialogue_line_skiped: bool = false


func _ready() -> void:
	dialogue_label.text = ""
	current_diag_line_index = -1


func show_dialogue() -> void:
	if text_loading:
		dialogue_line_skiped = true
	else:
		text_loading = true
		
		if current_diag_line_index < LaminaDialogueLines.lines.size() - 1:
			current_diag_line_index += 1
			dialogue_label.text = ""
		else:
			current_diag_line_index = -1
		
		_add_character()


func _add_character(current_character: int = 0) -> void:
	if current_diag_line_index == -1:
		dialogue_label.text = ""
		text_loading = false
		return
	
	var diag_line: String = LaminaDialogueLines.lines[current_diag_line_index]
	if dialogue_line_skiped:
		dialogue_label.text = diag_line
		dialogue_line_skiped = false
		text_loading = false
		dialogue_skip_timer.start(dialogue_skip_time)
		return
	
	dialogue_label.text += diag_line[current_character]
	
	await get_tree().create_timer(character_timing).timeout
	
	if current_character < diag_line.length() -1:
		_add_character(current_character + 1)
	else:
		await get_tree().create_timer(character_timing * 2).timeout
		text_loading = false
		dialogue_skip_timer.start(dialogue_skip_time)


func _on_dialogue_skip_timer_timeout() -> void:
	show_dialogue()
