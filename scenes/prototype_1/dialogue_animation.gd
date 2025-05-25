class_name DialogueAnimation
extends AnimationPlayer


@export var diag_func_name: String


var play_animation: Callable = func (animation_name: String) -> void:
	play(animation_name)


func _ready() -> void:
	if DialogueState:
		DialogueState.functions[diag_func_name] = play_animation
