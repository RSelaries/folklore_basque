extends CharacterBody3D


@export var walking_speed = 10.0
const JUMP_VELOCITY = 4.5


@export var mouse_sensitivity = 0.5


@onready var neck: Node3D = %Neck
@onready var fps_camera: Camera3D = %FpsCamera


func _unhandled_input(event: InputEvent) -> void:
	# Capture mouse on left click, release on 'escape' pressed
	if event is InputEventMouseButton:
		var mouse_button_event: InputEventMouseButton = event
		if mouse_button_event.button_index == 1:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			#fps_camera.make_current()
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Handling Camera
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		var event_mouse_motion : InputEventMouseMotion = event
		
		neck.rotate_y( -event_mouse_motion.relative.x * mouse_sensitivity * 0.01)
		fps_camera.rotate_x( -event_mouse_motion.relative.y * mouse_sensitivity * 0.01)
		fps_camera.rotation.x = clamp(fps_camera.rotation.x, deg_to_rad(-90), deg_to_rad(85) )



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
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
