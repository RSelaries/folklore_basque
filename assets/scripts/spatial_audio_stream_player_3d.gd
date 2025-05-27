@tool
class_name SpatialAudioStreamPlayer3D
extends AudioStreamPlayer3D


@export var max_raycast_distance: float = 30.0
@export var update_frequency_seconds: float = 0.5
@export var max_reverb_wetness: float = 0.5
@export var wall_lowpass_cutoff_amount: int = 600


@onready var player_ray_cast: RayCast3D = %PlayerRayCast


var _raycast_array: Array[RayCast3D] = []
var _distance_array: Array[float] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
var _last_update_time: float = 0.0
var _update_distances: bool = true
var _current_raycast_index: int = 0

# Audio bus
var _audio_bus_id: int
var _audio_bus_name: String = ""

# Effects
var _reverb_effect: AudioEffectReverb
var _lowpass_filter: AudioEffectLowPassFilter

# Target parameters
var _target_lowpass_cutoff: float = 2000.0
var _target_reverb_room_size: float = 0.0
var _target_reverb_wetness: float = 0.0
var _target_volume_db: float = 0.0


func _ready() -> void:
	# Create an audio bus for the effects
	_audio_bus_id = AudioServer.bus_count
	_audio_bus_name = "SpatialBus#"+str(_audio_bus_id)
	AudioServer.add_bus(_audio_bus_id)
	AudioServer.set_bus_name(_audio_bus_id, _audio_bus_name)
	AudioServer.set_bus_send(_audio_bus_id, bus)
	self.bus = _audio_bus_name
	
	#Add the effects to the custom bus
	AudioServer.add_bus_effect(_audio_bus_id, AudioEffectReverb.new(), 0)
	_reverb_effect = AudioServer.get_bus_effect(_audio_bus_id, 0)
	AudioServer.add_bus_effect(_audio_bus_id, AudioEffectLowPassFilter.new(), 1)
	_lowpass_filter = AudioServer.get_bus_effect(_audio_bus_id, 1)
	
	# Get the volume amount, then get it back to 0
	_target_volume_db = volume_db
	volume_db = -60.0
	
	# Init raycast max distances, and apppend them the the _raycast_array
	for child in get_children():
		if child is RayCast3D:
			var _raycast_child = child
			_raycast_child.target_position.x = max_raycast_distance
			
			if _raycast_child.name == "PlayerRayCast":
				_raycast_child.target_position = Vector3(0, 0, max_raycast_distance)
				break
			
			_raycast_array.append(_raycast_child)


func _on_update_raycast_distance(raycast: RayCast3D, raycast_id: int) -> void:
	raycast.force_raycast_update()
	var collider: Node3D = raycast.get_collider()
	
	if collider != null:
		_distance_array[raycast_id] = self.global_position.distance_to(raycast.get_collision_point())
	else:
		_distance_array[raycast_id] = -1
	
	raycast.enabled = false


func _on_update_spatial_audio(player: Node3D) -> void:
	_on_update_reverb()
	_on_update_lowpass_filter(player)


func _on_update_reverb() -> void:
	if _reverb_effect != null:
		# Find reverb parameters
		var room_size: float = 0.0
		var wetness: float = 1.0
		
		for distance in _distance_array:
			if distance >= 0:
				# Find the average room size based on the raycast distances that are valid
				room_size += (distance / max_raycast_distance) / float(_distance_array.size())
				room_size = min(room_size, 1.0)
			else:
				# If a raycast did not hit anything we will reduce the reverb effect
				wetness -= 1.0 / float(_distance_array.size())
				wetness = max(wetness, 0.0)
		
		_target_reverb_wetness = wetness
		_target_reverb_room_size = room_size


func _on_update_lowpass_filter(player: Node3D) -> void:
	if _lowpass_filter != null:
		player_ray_cast.target_position = (player.global_position - self.global_position).normalized() * max_raycast_distance
		
		var collider: Node3D = player_ray_cast.get_collider()
		var lowpass_cutoff: float = 2000
		
		if collider != null:
			var ray_distance = self.global_position.distance_to(player_ray_cast.get_collision_point())
			var distance_to_player = self.global_position.distance_to(player.global_position)
			var wall_to_player_ratio = ray_distance / max(distance_to_player, 0.001)
			
			if ray_distance < distance_to_player:
				lowpass_cutoff = wall_lowpass_cutoff_amount * wall_to_player_ratio
		
		_target_lowpass_cutoff = lowpass_cutoff


func _lerp_parameters(delta) -> void:
	volume_db = lerp(volume_db, _target_volume_db, delta)
	_lowpass_filter.cutoff_hz = lerp(_lowpass_filter.cutoff_hz, _target_lowpass_cutoff, delta * 5.0)
	_reverb_effect.wet = lerp(_reverb_effect.wet, _target_reverb_wetness * max_reverb_wetness, delta * 5.0)
	_reverb_effect.room_size = lerp(_reverb_effect.room_size, _target_reverb_room_size, delta * 5.0)


func _physics_process(delta: float) -> void:
	_last_update_time += delta
	
	# Test if we should update the raycast values
	if _update_distances:
		_on_update_raycast_distance(_raycast_array[_current_raycast_index], _current_raycast_index)
		_current_raycast_index += 1
		
		if _current_raycast_index >= _distance_array.size():
			_current_raycast_index = 0
			_update_distances = false
	
	# Test if we should update the spatial sound values
	if _last_update_time > update_frequency_seconds:
		var player_camera = get_viewport().get_camera_3d() # /!\ THIS COULD CHANGE /!\
		if player_camera != null:
			_on_update_spatial_audio(player_camera)
		
		_update_distances = true
		_last_update_time = 0.0
	
	# Lerp parameters far a smooth transition
	_lerp_parameters(delta)
