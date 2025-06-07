extends Area3D


@onready var display: Sprite3D = %Display
@onready var canvas_group: CanvasGroup = %CanvasGroup


var focused: bool = true:
	set(value):
		focused = value
		if value:
			canvas_group.material.set_shader_parameter("width", 10.0)
			PlayerState.interaction = PlayerState.Interactions.USE
		else:
			canvas_group.material.set_shader_parameter("width", 0.0)


func _ready() -> void:
	canvas_group.material.set_shader_parameter("width", 0.0)


func interact() -> void:
	var path: String = get_documents_folder().path_join("dream_scape_awake.exe")
	OS.execute(path, [])


func get_documents_folder() -> String:
	if OS.get_name() == "Windows":
		var userprofile = OS.get_environment("USERPROFILE")
		if userprofile != "":
			return userprofile.path_join("Documents")
	return ""
