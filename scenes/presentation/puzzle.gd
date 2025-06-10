extends Area3D


@onready var minis_games: Node = %MinisGames
@onready var puzzle_windows_layer: CanvasLayer = %PuzzleWindowsLayer


var focused: bool = true:
	set(value):
		focused = value
		if value:
			PlayerState.interaction = PlayerState.Interactions.USE


func _ready() -> void:
	if minis_games and "hide_puzzle" in minis_games:
		minis_games.hide_puzzle = hide_puzzle


func interact() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	puzzle_windows_layer.visible = true
	PlayerState.input_listening = false
	if minis_games.has_method("toggle_child_visibility"):
		minis_games.toggle_child_visibility(true)


func _unhandled_input(event: InputEvent) -> void:
	if puzzle_windows_layer.visible:
		if event.is_action_pressed("esc_menu"):
			hide_puzzle()
		
		get_window().set_input_as_handled()


func hide_puzzle() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	puzzle_windows_layer.visible = false
	PlayerState.input_listening = true
	if minis_games.has_method("toggle_child_visibility"):
		minis_games.toggle_child_visibility(false)
