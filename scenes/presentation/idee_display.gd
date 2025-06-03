extends Area3D


@onready var idee_canvas_layer: CanvasLayer = %IdeeCanvasLayer
@onready var pages: Control = %Pages
@onready var page_1_next_btn: Button = %Page1NextBtn
@onready var page_2_next_btn: Button = %Page2NextBtn


var focused: bool = false:
	set(value):
		focused = value
		if value:
			PlayerState.interaction = PlayerState.Interactions.USE


func _ready() -> void:
	idee_canvas_layer.visible = false
	page_1_next_btn.pressed.connect(change_page_to.bind("Page2"))
	page_2_next_btn.pressed.connect(change_page_to.bind("none"))
	change_page_to("Page1")
	
	visibility_changed.connect(func(): PlayerState.input_listening = !visible)


func interact() -> void:
	idee_canvas_layer.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func change_page_to(page_name: String) -> void:
	if page_name == "none":
		idee_canvas_layer.visible = false
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		return
	
	for page: Control in pages.get_children():
		if page.name == page_name:
			page.visible = true
		else:
			page.visible = false


func _unhandled_input(_event: InputEvent) -> void:
	if idee_canvas_layer.visible:
		get_window().set_input_as_handled()
