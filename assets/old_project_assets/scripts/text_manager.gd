extends CanvasLayer


func show_text(text: String, time: float = 1) -> void:
	%TextDisplay.text = text
	
	await get_tree().create_timer(time).timeout
	
	%TextDisplay.text = ""
