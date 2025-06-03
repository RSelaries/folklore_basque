extends Window


@onready var transaparance_jsp: Node3D = %TransaparanceJsp


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	visibility_changed.connect(_on_visiility_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_visiility_changed() -> void:
	if visible:
		transaparance_jsp.visible = visible
