extends Area3D


@onready var test_3d_group: CanvasGroup = %Test3DGroup
@onready var test_scene_shader: Area3D = get_parent().find_child("TestScene3DShader")


var focused: bool = false:
	set(value):
		focused = value
		if value:
			PlayerState.interaction = PlayerState.Interactions.USE
			test_3d_group.material.set_shader_parameter("width", 10.0)
		else:
			test_3d_group.material.set_shader_parameter("width", 0.0)


func interact() -> void:
	if test_scene_shader.has_method("interact"):
		test_scene_shader.interact()
		if test_scene_shader.find_child("TestScene3DWindowShader").has_method("set_shader"):
			test_scene_shader.find_child("TestScene3DWindowShader").set_shader(false)


func _unhandled_input(event: InputEvent) -> void:
	if test_scene_shader.find_child("TestScene3DWindowShader").visible:
		if event.is_action_pressed("esc_menu"):
			hide_window()


func hide_window() -> void:
	if test_scene_shader.has_method("hide_window"):
		test_scene_shader.hide_window()
