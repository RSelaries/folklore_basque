class_name DialogueBalloon
extends CanvasLayer


@export var next_action: String = "interact"
@export var skip_action: String = "return"

@onready var balloon: Control = %Balloon

@onready var character_label: Label = %CharacterLabel
@onready var dialogue_label: DialogueLabel = %DialogueLabel
@onready var dialogue_responses_menu: DialogueResponsesMenu = %DialogueResponsesMenu
@onready var talk_sound_effect: AudioStreamPlayer = %TalkSoundEffect


var dialogue: DialogueResource
var temporary_game_states: Array = []
var is_waiting_for_input: bool = false
var will_hide_balloon: bool = false
var mutation_cooldown = Timer.new()
var dialogue_line: DialogueLine:
	set(value):
		if !value:
			queue_free()
			return
		
		dialogue_line = value
		apply_dialogue_line()


func _ready() -> void:
	balloon.hide()
	balloon.gui_input.connect(_on_balloon_gui_input)
	
	if not dialogue_responses_menu.next_action:
		dialogue_responses_menu.next_action = next_action
	dialogue_responses_menu.response_selected.connect(_on_response_selected)
	
	mutation_cooldown.timeout.connect(_on_mutation_cooldown_timeout)
	add_child(mutation_cooldown)


func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSLATION_CHANGED and is_instance_valid(dialogue_label):
		var visible_ratio: float = dialogue_label.visible_ratio
		dialogue_line = await DialogueManager.get_next_dialogue_line(dialogue, dialogue_line.id, temporary_game_states)
		if visible_ratio < 1.0:
			dialogue_label.skip_typing()


func start(dialogue_ressource: DialogueResource, title: String, extra_game_states: Array = []) -> void:
	temporary_game_states = extra_game_states
	is_waiting_for_input = false
	dialogue = dialogue_ressource
	
	dialogue_line = await DialogueManager.get_next_dialogue_line(dialogue, title, temporary_game_states)


func next(next_id: String) -> void:
	dialogue_line = await DialogueManager.get_next_dialogue_line(dialogue, next_id, temporary_game_states)


func apply_dialogue_line() -> void:
	mutation_cooldown.stop()
	
	is_waiting_for_input = false
	balloon.focus_mode = Control.FOCUS_ALL
	balloon.grab_focus()
	
	# set character name
	if dialogue_line.character:
		character_label.visible = true
		character_label.text = dialogue_line.character
	
	# set dialogue
	dialogue_label.hide()
	dialogue_label.dialogue_line = dialogue_line
	
	# set response
	dialogue_responses_menu.hide()
	dialogue_responses_menu.responses = dialogue_line.responses
	
	# type the text
	balloon.show()
	will_hide_balloon = false
	dialogue_label.show()
	if dialogue_line.text:
		dialogue_label.type_out()
		await dialogue_label.finished_typing
	
	# wait for input
	if dialogue_line.responses.size() > 0:
		balloon.focus_mode = Control.FOCUS_NONE
		dialogue_responses_menu.show()
	elif dialogue_line.time:
		var time: float = 0.0
		if float(dialogue_line.time):
			time = float(dialogue_line.time) * 0.02
		await get_tree().create_timer(time).timeout
		next(dialogue_line.next_id)
	else:
		is_waiting_for_input = true
		balloon.focus_mode = Control.FOCUS_ALL
		balloon.grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	_on_balloon_gui_input(event)
	
	# Only the ballon can be interacted with during dialogue
	get_viewport().set_input_as_handled()


func _on_response_selected(response: DialogueResponse) -> void:
	next(response.next_id)


func _on_balloon_gui_input(event: InputEvent) -> void:
	if dialogue_label.is_typing:
		var mouse_was_clicked: bool = event.is_action_pressed(next_action)
		var skip_button_was_pressed: bool = event.is_action_pressed(skip_action)
		if mouse_was_clicked or skip_button_was_pressed:
			get_viewport().set_input_as_handled()
			dialogue_label.skip_typing()
			return
	
	if !is_waiting_for_input: return
	if dialogue_line.responses.size() > 0: return
	
	get_viewport().set_input_as_handled()
	
	if event.is_action_pressed(next_action):
		next(dialogue_line.next_id)


func _on_mutation_cooldown_timeout() -> void:
	if will_hide_balloon:
		will_hide_balloon = false
		balloon.hide()


func _on_dialogue_label_spoke(letter: String, _letter_index: int, _speed: float) -> void:
	if not letter in [" ", "."]:
		talk_sound_effect.pitch_scale = randf_range(0.8, 1.2)
		talk_sound_effect.play()
