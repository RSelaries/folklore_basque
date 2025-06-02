@tool
class_name PuzzleWindow
extends Window


@export var solution_position: Vector2:
	set(value):
		solution_position = value
		position = value
@export var puzzle_piece_texture: Texture2D:
	set(texture):
		puzzle_piece_texture = texture
		if piece_texture:
			piece_texture.texture = texture


@onready var piece_texture: TextureRect = %PieceTexture


var window_size: Vector2 = Vector2(370, 300)
var resolved: bool = false


func _ready() -> void:
	if piece_texture:
		piece_texture.texture = puzzle_piece_texture
	
	size = window_size
	#position = solution_position
	title = name
	always_on_top = true


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		position = solution_position
	
	if position.distance_to(solution_position) < 60:
		title = "resolved"
		resolved = true
	else:
		title = name
		resolved = false
