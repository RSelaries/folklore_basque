@tool
extends SubViewportContainer


func _ready() -> void:
	get_tree().root.size_changed.connect(_resize_subviewport)
	_resize_subviewport()


func _resize_subviewport() -> void:
	if find_child("SubViewport"):
		var subviewport: SubViewport = find_child("SubViewport")
		
		if get_parent() is Control:
			subviewport.size = get_parent().size
