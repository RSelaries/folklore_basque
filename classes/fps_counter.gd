class_name FpsCounter
extends CanvasLayer


@onready var fps_label: Label = get_child(0).get_child(0).get_child(0)


static func create_fps_counter() -> FpsCounter:
	var root_node: CanvasLayer = FpsCounter.new()
	
	var fps_label_node: Label = Label.new()
	fps_label_node.name = "FpsLabel"
	fps_label_node.unique_name_in_owner = true
	
	var margin_container: MarginContainer = MarginContainer.new()
	margin_container.add_theme_constant_override("margin_top", 7)
	margin_container.add_theme_constant_override("margin_bottom", 7)
	margin_container.add_theme_constant_override("margin_left", 20)
	margin_container.add_theme_constant_override("margin_right", 20)
	
	margin_container.add_child(fps_label_node)
	
	var panel_container: PanelContainer = PanelContainer.new()
	panel_container.add_child(margin_container)
	
	root_node.add_child(panel_container)
	
	return root_node


func _process(_delta: float) -> void:
	if fps_label:
		fps_label.text = "FPS : " + str(Engine.get_frames_per_second())
