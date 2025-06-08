extends Node


signal interaction_changed_to(interaction)


enum Interactions {NONE, SPEEK, USE}
var interaction: Interactions = Interactions.NONE:
	set(value):
		interaction = value
		interaction_changed_to.emit(value)


var player_scene: PlayerFpsController
var input_listening: bool = true

var flying: bool = false
