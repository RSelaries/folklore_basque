extends CanvasLayer


var dithering_frame_count: int = 0
var dithering_flip: bool = false

@onready var dithering_material: ShaderMaterial = $Dithering.material


func _physics_process(_delta: float) -> void:
	if dithering_frame_count == 30:
		if dithering_flip:
			dithering_material.set_shader_parameter("dither_size", 3)
		else:
			dithering_material.set_shader_parameter("dither_size", 2)
		dithering_material.set_shader_parameter("colors", randi_range(10, 14))
		dithering_frame_count = 0
	
	dithering_frame_count += 1
