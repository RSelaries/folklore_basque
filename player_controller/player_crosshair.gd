extends CanvasLayer


@onready var crosshair_container: CenterContainer = %CrosshairContainer


func _ready() -> void:
	PlayerState.interaction_changed_to.connect(_on_player_interaction_changed)


func _on_player_interaction_changed(interaction: PlayerState.Interactions) -> void:
	match interaction:
		PlayerState.Interactions.NONE:
			_change_crosshair_to("None")
		
		PlayerState.Interactions.SPEEK:
			_change_crosshair_to("Speek")
		
		PlayerState.Interactions.USE:
			_change_crosshair_to("None")


func _change_crosshair_to(to: String) -> void:
	for child: CanvasItem in crosshair_container.get_children():
		if child.name == to:
			child.visible = true
		else:
			child.visible = false
