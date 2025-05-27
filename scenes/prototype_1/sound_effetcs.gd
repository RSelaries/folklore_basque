class_name SoundEffects
extends Node


@onready var walk_sound_1: AudioStreamPlayer = %WalkSound1
@onready var walk_sound_2: AudioStreamPlayer = %WalkSound2
@onready var walk_sound_3: AudioStreamPlayer = %WalkSound3
@onready var walk_sound_4: AudioStreamPlayer = %WalkSound4


func play_walk_sound() -> void:
	walk_sound_1.pitch_scale = randf_range(0.7, 1.4)
	walk_sound_2.pitch_scale = randf_range(0.7, 1.4)
	walk_sound_3.pitch_scale = randf_range(0.7, 1.4)
	walk_sound_4.pitch_scale = randf_range(0.7, 1.4)
	
	walk_sound_1.play()
	await get_tree().create_timer(0.15).timeout
	walk_sound_2.play()
	await get_tree().create_timer(0.2).timeout
	walk_sound_3.play()
	
