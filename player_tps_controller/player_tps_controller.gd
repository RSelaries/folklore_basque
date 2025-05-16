@tool
class_name PlayerTpsController
extends CharacterBody3D


# Camera ====================
@export_group("Camera")
@export_enum("TPS Freecam", "TPS Locked cam") var camera_control: String = "TPS Freecam"
@export var camera_sensitivity: float = 0.1


# Velocity ====================
@export_group("Velocity Values")
@export var walk_speed: float = 5.0
@export var jump_velocity: float = 4.5
@export var deceleration: float = 0.5
@export var acceleration: float = 10.0


@onready var y_rotation: Node3D = %YRotation
@onready var x_rotation: Node3D = %XRotation
@onready var camera_3d: Camera3D = %Camera3D


func _unhandled_input(event: InputEvent) -> void:
	if Engine.is_editor_hint():
		return
	
	# Capture mouse on left click, release on 'escape' pressed
	if event is InputEventMouseButton and event.button_index == 1:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Handling Camera
	if camera_control == "TPS Freecam":
		if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			var event_mouse_motion : InputEventMouseMotion = event
			
			y_rotation.rotate_y(-event_mouse_motion.relative.x * camera_sensitivity * 0.01)
			x_rotation.rotate_x(-event_mouse_motion.relative.y * camera_sensitivity * 0.01)
			x_rotation.rotation.x = clamp(x_rotation.rotation.x, deg_to_rad(-90), deg_to_rad(85) )


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir: Vector2 = Input.get_vector("fps_movement_left", "fps_movement_right", "fps_movement_forward", "fps_movement_backward")
	var direction: Vector3 = (y_rotation.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * walk_speed
		velocity.z = direction.z * walk_speed
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.z = move_toward(velocity.z, 0, deceleration)

	move_and_slide()
