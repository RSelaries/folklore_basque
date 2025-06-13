extends Area3D


@onready var test_3d_group: CanvasGroup = %Test3DGroupShader
@onready var test_scene_3d_window: Window = %TestScene3DWindowShader
@onready var test_3d_canvas_layer: CanvasLayer = %Test3DCanvasLayerShader
@onready var test_3d_scene: Node3D = %Test3dScene


var focused: bool = false:
	set(value):
		focused = value
		if value:
			PlayerState.interaction = PlayerState.Interactions.USE
			test_3d_group.material.set_shader_parameter("width", 10.0)
		else:
			test_3d_group.material.set_shader_parameter("width", 0.0)


func interact() -> void:
	test_scene_3d_window.visible = true
	test_3d_canvas_layer.visible = true
	test_scene_3d_window.grab_focus()


func _unhandled_input(event: InputEvent) -> void:
	if test_scene_3d_window.visible:
		if event.is_action_pressed("esc_menu"):
			hide_window()


func hide_window() -> void:
	test_scene_3d_window.visible = false
	test_3d_canvas_layer.visible = false
	get_window().grab_focus()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
