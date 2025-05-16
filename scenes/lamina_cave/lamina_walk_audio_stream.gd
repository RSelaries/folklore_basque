extends AudioStreamPlayer3D


func _ready() -> void:
	var rdm_nbr: float = RandomNumberGenerator.new().randf_range(0.0, 6.0)
	play(rdm_nbr)
