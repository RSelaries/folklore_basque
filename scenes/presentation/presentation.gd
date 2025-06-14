extends Node3D


@onready var player_fps_controller: PlayerFpsController = %PlayerFpsController
@onready var memoire_label: Label3D = %MemoireLabel


func _ready() -> void:
	get_window().mode = Window.MODE_WINDOWED
	get_window().size = Vector2(2, 2)
	get_window().mode = Window.MODE_FULLSCREEN
	get_window().set_deferred("mode", Window.MODE_FULLSCREEN)
	get_window().transparent = false
	
	var path: String = get_documents_folder().path_join("dream_scape_awake.exe")
	#if not DirAccess.dir_exists_absolute(path):
	if not FileAccess.file_exists(path):
		memoire_label.text = "dream_scape_awake.exe non trouvé"
		print("FileAccess.file_exists(path) => ", FileAccess.file_exists(path))
		print("path : ", path)


func get_documents_folder() -> String:
	if OS.get_name() == "Windows":
		var userprofile = OS.get_environment("USERPROFILE")
		if userprofile != "":
			return userprofile.path_join("Documents")
	return ""
