extends Area3D


var focused: bool = true:
	set(value):
		focused = value
		if value:
			PlayerState.interaction = PlayerState.Interactions.NONE


func _ready() -> void:
	pass


func interact() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
