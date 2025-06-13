extends Area3D


@onready var teleport_location: Marker3D = %TeleportLocation
@onready var black_fade_in_out: ColorRect = %BlackFadeInOut


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if body is PlayerFpsController:
		var tween: Tween = get_tree().create_tween()
		tween.tween_property(black_fade_in_out, "color", Color("#000f"), 1.0)
		tween.tween_property(black_fade_in_out, "color", Color("#000f"), 0.2)
		tween.tween_property(black_fade_in_out, "color", Color("#0000"), 1.0)
		await get_tree().create_timer(0.5).timeout
		PlayerState.input_listening = false
		await get_tree().create_timer(0.6).timeout
		var player_scene: PlayerFpsController = owner.find_child("PlayerFpsController")
		if player_scene:
			player_scene.global_position = teleport_location.global_position
			player_scene.global_rotation = teleport_location.global_rotation
			player_scene.neck.rotation_degrees = Vector3(0, 0, 0)
			await get_tree().create_timer(0.2).timeout
		else:
			black_fade_in_out.color = "#0000"
		PlayerState.input_listening = true
