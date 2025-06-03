extends Area3D


@onready var old_pnc_window: Window = %OldPncWindow
@onready var old_pnc_canvas_layer: CanvasLayer = %OldPncCanvasLayer
@onready var old_pnc_group: CanvasGroup = %OldPncGroup


var old_pnc_group_shader_material: ShaderMaterial


var focused: bool = false:
	set(value):
		focused = value
		if value:
			PlayerState.interaction = PlayerState.Interactions.USE
			old_pnc_group_shader_material.set_shader_parameter("width", 10.0)
		else:
			old_pnc_group_shader_material.set_shader_parameter("width", 0.0)


func _ready() -> void:
	old_pnc_group_shader_material = old_pnc_group.material


func interact() -> void:
	old_pnc_window.visible = true
	old_pnc_canvas_layer.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	PlayerState.input_listening = false


func _unhandled_input(event: InputEvent) -> void:
	if old_pnc_window.visible:
		if event.is_action_pressed("esc_menu"):
			old_pnc_window.visible = false
			old_pnc_canvas_layer.visible = false
			PlayerState.input_listening = true
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		
		get_window().set_input_as_handled()
