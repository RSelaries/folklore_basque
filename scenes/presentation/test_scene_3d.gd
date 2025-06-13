extends Area3D


var focused: bool = false:
	set(value):
		focused = value
		if value:
			PlayerState.interaction = PlayerState.Interactions.USE
