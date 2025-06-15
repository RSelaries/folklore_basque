@tool
class_name SubviewportSprite
extends Sprite3D


func _ready() -> void:
	_update_texture()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		_update_texture()


func _update_texture() -> void:
	for child in get_children():
		if child is SubViewport:
			texture = ViewportTexture.new()
			texture.viewport_path = child.get_path()
