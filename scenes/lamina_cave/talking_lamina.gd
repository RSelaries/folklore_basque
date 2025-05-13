extends StaticBody3D


@onready var lamina_canvas_group: CanvasGroup = self.find_child("Lamina")
@onready var dialogue_manager: Node3D = %DialogueManager


var focused: bool = false:
	set(value):
		focused = value
		_update_lamina_outline(value)
		_update_player_crosshair(value)


func interact() -> void:
	dialogue_manager.show_dialogue()


func _update_lamina_outline(is_focused: bool) -> void:
	if not lamina_canvas_group:
		return
	
	if is_focused == true:
		if lamina_canvas_group.material:
			var lamina_shader: ShaderMaterial = lamina_canvas_group.material
			lamina_shader.set_shader_parameter("width", 10.0)
	
	elif lamina_canvas_group.material:
			var lamina_shader: ShaderMaterial = lamina_canvas_group.material
			lamina_shader.set_shader_parameter("width", 0.0)


func _update_player_crosshair(is_focused: bool) -> void:
	if is_focused:
		PlayerState.interaction = PlayerState.Interactions.SPEEK
		
