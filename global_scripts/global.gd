@tool
extends Node


const rng_seed: int = 69420

@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()


func _ready() -> void:
	rng.seed = rng_seed
	
	if not Engine.is_editor_hint():
		Console.add_command("fly", _console_toggle_fly_mode)


func _console_toggle_fly_mode() -> void:
	PlayerState.flying = !PlayerState.flying


#func _add_fps_counter() -> void:
	#get_tree().root.add_child.call_deferred(FpsCounter.create_fps_counter())


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		get_tree().quit()
