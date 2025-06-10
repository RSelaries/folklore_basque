extends Area3D


@onready var boucle_window: Window = %BoucleWindow
@onready var boucle_canvas_layer: CanvasLayer = %BoucleCanvasLayer
@onready var boucle_group: CanvasGroup = %boucle_group


var focused: bool = false:
	set(value):
		focused = value
		if value:
			PlayerState.interaction = PlayerState.Interactions.USE
			boucle_group.material.set_shader_parameter("width", 10.0)
		else:
			boucle_group.material.set_shader_parameter("width", 0.0)


func interact() -> void:
	boucle_window.visible = true
	boucle_canvas_layer.visible = true


func _unhandled_input(event: InputEvent) -> void:
	if boucle_window.visible:
		if event.is_action_pressed("esc_menu"):
			hide_window()


func hide_window() -> void:
	boucle_window.visible = false
	boucle_canvas_layer.visible = false
	get_window().grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
