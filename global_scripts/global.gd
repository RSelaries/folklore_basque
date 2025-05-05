@tool
extends Node


const rng_seed: int = 69420

var RNG: RandomNumberGenerator


func _ready() -> void:
	RNG = RandomNumberGenerator.new()
	RNG.seed = rng_seed
	
	_add_fps_counter()


func _add_fps_counter() -> void:
	get_tree().root.add_child.call_deferred(FpsCounter.create_fps_counter())
