extends Light3D

@export var min_light_energy: float = 0.5
@export var max_light_energy: float = 2.0

@export var flicker_speed: float = 20.0

@export var noise_texture: NoiseTexture2D
var index: float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	index += delta * flicker_speed
	
	if noise_texture and noise_texture.noise:
		var sampled_noise: float = (abs(noise_texture.noise.get_noise_1d(index)) * max_light_energy) + min_light_energy
		
		light_energy = sampled_noise
