extends Area3D


@onready var prot_canvas_group: CanvasGroup = %ProtCanvasGroup


var focused: bool = false:
	set(value):
		focused = value
		if value:
			PlayerState.interaction = PlayerState.Interactions.USE
			prot_canvas_group.material.set_shader_parameter("width", 10.0)
		else:
			prot_canvas_group.material.set_shader_parameter("width", 0.0)


func interact() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	#get_tree().change_scene_to_file("uid://cf6ok0syg18r") # Prototype Scene
	get_tree().change_scene_to_file("uid://78wgp66j7b2c") # Start Menu
