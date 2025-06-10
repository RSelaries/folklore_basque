extends Node3D


enum Modes {TOP_DOWN_PIXEL, TOP_DOWN, FPS}
@export var mode: Modes = Modes.FPS
@onready var world_environment: WorldEnvironment = $Main/WorldEnvironment


func _ready() -> void:
	match mode:
		Modes.FPS: _fps_classic_mode()
		Modes.TOP_DOWN_PIXEL: _top_down_pixelation_mode(true)
		Modes.TOP_DOWN: _top_down_pixelation_mode()


func _top_down_pixelation_mode(pixeized: bool = false) -> void:
	get_window().transparent_bg = true
	if pixeized:
		get_tree().root.content_scale_size = Vector2i(426, 240)
		get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
	
	$PlayerFpsController/Neck/FpsCamera/OrthoCam.make_current()
	$PlayerFpsController.mouse_sensitivity = 0.0


func _fps_classic_mode() -> void:
	get_window().transparent_bg = false
	$PlayerFpsController/Neck/FpsCamera.make_current()
