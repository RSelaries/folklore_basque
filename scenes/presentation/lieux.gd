extends Area3D


@onready var lieux_windows_layer: CanvasLayer = %LieuxWindowsLayer
@onready var lieux_windows: Window = %LieuxWindows


var fenetres_lieux_node: Node


var focused: bool = true:
	set(value):
		focused = value
		if value:
			PlayerState.interaction = PlayerState.Interactions.USE


func _ready() -> void:
	lieux_windows_layer.visible = false


func interact() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	lieux_windows_layer.visible = true
	lieux_windows.visible = true
	PlayerState.input_listening = false


func _unhandled_input(event: InputEvent) -> void:
	if lieux_windows_layer.visible:
		if event.is_action_pressed("esc_menu"):
			PlayerState.input_listening = true
			lieux_windows.visible = false
			lieux_windows_layer.visible = false
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
		get_window().set_input_as_handled()
