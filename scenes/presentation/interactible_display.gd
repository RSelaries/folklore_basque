extends Area3D


var focused: bool = true:
	set(value):
		focused = value
		if value:
			shader_matieral.set_shader_parameter("outline_width", 0.018)
			PlayerState.interaction = PlayerState.Interactions.USE
		else:
			shader_matieral.set_shader_parameter("outline_width", 0.0)

var shader_matieral: ShaderMaterial


func _ready() -> void:
	shader_matieral = $MeshInstance3D.get_active_material(0)


func _interact() -> void:
	pass
