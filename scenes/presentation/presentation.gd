extends Node3D


@onready var player_fps_controller: PlayerFpsController = %PlayerFpsController


func _ready() -> void:
	get_window().mode = Window.MODE_FULLSCREEN
	get_window().transparent = false
	pass
	#player_fps_controller.find_child("Neck").find_child("FpsCamera").make_current()
	
	#player_fps_controller.walking_speed = 1.0
	#player_fps_controller.mouse_sensitivity = 0.04
	#var tween: Tween = get_tree().create_tween()
	#tween.tween_property(player_fps_controller, "mouse_sensitivity", 0.2, 3.0)
	#tween.tween_property(player_fps_controller, "walking_speed", 5.0, 3.0)
