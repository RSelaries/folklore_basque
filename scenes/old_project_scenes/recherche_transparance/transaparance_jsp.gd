extends Node3D


@onready var player_fps_controller: PlayerFpsController = %PlayerFpsController


func _ready() -> void:
	if visible:
		$AnimationPlayer.play("sky_dissolve")
	else:
		visibility_changed.connect(func():
			if visible:
				$AnimationPlayer.play("sky_dissolve")
				player_fps_controller.fps_camera.make_current()
		)
