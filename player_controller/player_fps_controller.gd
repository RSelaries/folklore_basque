class_name PlayerFpsController
extends CharacterBody3D


@export var walking_speed = 10.0
const JUMP_VELOCITY = 4.5


@export var mouse_sensitivity = 0.5


@onready var neck: Node3D = %Neck
@onready var fps_camera: Camera3D = %FpsCamera
@onready var interaction_raycast: RayCast3D = %InteractionRaycast


var currently_focused_node: Node3D


func _ready() -> void:
	PlayerState.player_scene = self


func _unhandled_input(event: InputEvent) -> void:
	# Capture mouse on left click, release on 'escape' pressed
	if event is InputEventMouseButton and event.button_index == 1:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Handling Camera
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var event_mouse_motion : InputEventMouseMotion = event
		
		neck.rotate_y( -event_mouse_motion.relative.x * mouse_sensitivity * 0.01)
		fps_camera.rotate_x( -event_mouse_motion.relative.y * mouse_sensitivity * 0.01)
		fps_camera.rotation.x = clamp(fps_camera.rotation.x, deg_to_rad(-90), deg_to_rad(85) )
	
	# Handling interact
	if event.is_action_pressed("interact"):
		if interaction_raycast.get_collider():
			var collider: Node3D = interaction_raycast.get_collider()
			if collider.has_method("interact"):
				collider.interact()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("fps_movement_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("fps_movement_left", "fps_movement_right", "fps_movement_forward", "fps_movement_backward")
	var direction := (neck.global_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * walking_speed
		velocity.z = direction.z * walking_speed
	else:
		velocity.x = move_toward(velocity.x, 0, walking_speed)
		velocity.z = move_toward(velocity.z, 0, walking_speed)

	move_and_slide()


func _process(_delta: float) -> void:
	_check_for_interaction()


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
