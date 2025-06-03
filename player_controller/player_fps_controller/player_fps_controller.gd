class_name PlayerFpsController
extends CharacterBody3D


@export var camera_smoothing: bool = false
@export var smoothing_speed: float = 8.0  # Plus c’est grand, plus c’est rapide

@export var can_zoom: bool = false
@export var zoom_speed: float = 100.0

@export var walking_speed = 10.0
@export var jump_velocity = 4.5

@export var acceleration: float = 10.0
@export var deceleration: float = 12.0

@export var mouse_sensitivity = 0.5


@onready var neck: Node3D = %Neck
@onready var fps_camera: Camera3D = %FpsCamera
@onready var interaction_raycast: RayCast3D = %InteractionRaycast
@onready var crosshair_container: CenterContainer = %CrosshairContainer


var currently_focused_node: Node3D

var target_rotation_x: float = 0.0
var target_rotation_y: float = 0.0

var target_zoom: float = 75


func _ready() -> void:
	PlayerState.player_scene = self
	if not visible:
		crosshair_container.visible = false


func _unhandled_input(event: InputEvent) -> void:
	if not visible or PlayerState.input_listening == false:
		return
	
	# Capture mouse on left click, release on 'escape' pressed
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		fps_camera.make_current()
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Handling Camera
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var event_mouse_motion : InputEventMouseMotion = event
		
		if camera_smoothing:
			target_rotation_y += -event_mouse_motion.relative.x * mouse_sensitivity * 0.01
			target_rotation_x += -event_mouse_motion.relative.y * mouse_sensitivity * 0.01
			target_rotation_x = clamp(target_rotation_x, deg_to_rad(-90), deg_to_rad(85) )
		else:
			neck.rotate_y( -event_mouse_motion.relative.x * mouse_sensitivity * 0.01)
			fps_camera.rotate_x( -event_mouse_motion.relative.y * mouse_sensitivity * 0.01)
			fps_camera.rotation.x = clamp(fps_camera.rotation.x, deg_to_rad(-90), deg_to_rad(85) )
			
			target_rotation_y = neck.rotation.y
			target_rotation_x = fps_camera.rotation.x
	
	# Handling interact
	if event.is_action_pressed("interact"):
		if interaction_raycast.get_collider():
			var collider: Node3D = interaction_raycast.get_collider()
			if collider.has_method("interact"):
				collider.interact()
	
	# Handling zooming
	if event.is_action_pressed("zoom_in"):
		target_zoom *= 0.8
	elif event.is_action_pressed("zoom_out"):
		target_zoom *= 1.2
	target_zoom = clamp(target_zoom, 40, 80)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if not PlayerState.input_listening:
		move_and_slide()
		return
	
	# Handle jump.
	if Input.is_action_just_pressed("fps_movement_jump") and is_on_floor():
		velocity.y = jump_velocity
	
	# Handle Camera Smoothing
	if camera_smoothing:
		var current_y = neck.rotation.y
		var current_x = fps_camera.rotation.x
		
		neck.rotation.y = lerp_angle(current_y, target_rotation_y, delta * smoothing_speed)
		fps_camera.rotation.x = lerp_angle(current_x, target_rotation_x, delta * smoothing_speed)
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("fps_movement_left", "fps_movement_right", "fps_movement_forward", "fps_movement_backward")
	var direction := (neck.global_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var target_velocity = direction * walking_speed
	if Input.is_action_pressed("sprint"):
			target_velocity *= 3.0
	
	if direction:
		var horizontal_velocity = Vector2(velocity.x, velocity.z)
		var target_horizontal_velocity = Vector2(target_velocity.x, target_velocity.z)
		
		var new_horizontal_velocity = horizontal_velocity.move_toward(target_horizontal_velocity, acceleration * delta)
		
		velocity.x = new_horizontal_velocity.x
		velocity.z = new_horizontal_velocity.y
	else:
		var horizontal_velocity = Vector2(velocity.x, velocity.z)
		var new_horizontal_velocity = horizontal_velocity.move_toward(Vector2.ZERO, deceleration * delta)
		velocity.x = new_horizontal_velocity.x
		velocity.z = new_horizontal_velocity.y
	
	move_and_slide()


func _process(delta: float) -> void:
	_check_for_interaction()
	
	# Handle Camera Zoom
	if can_zoom:
		fps_camera.fov = move_toward(fps_camera.fov, target_zoom, zoom_speed * delta)


func _check_for_interaction() -> void:
	if not interaction_raycast.get_collider():
		if currently_focused_node and "focused" in currently_focused_node:
			currently_focused_node.focused = false
			currently_focused_node = null
		
		PlayerState.interaction = PlayerState.Interactions.NONE
		return
	
	var collider: Node3D = interaction_raycast.get_collider()
	
	if collider == currently_focused_node:
		return
	else:
		if currently_focused_node and "focused" in currently_focused_node:
			currently_focused_node.focused = false
		
		currently_focused_node = collider
	
	if "focused" in collider:
		collider.focused = true
	else:
		PlayerState.interaction = PlayerState.Interactions.NONE
