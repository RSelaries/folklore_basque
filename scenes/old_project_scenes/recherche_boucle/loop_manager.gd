extends Node


var current_state: String = "first_loop"


func _ready() -> void:
	%Obstacle1.visible = false
	%Obstacle2.visible = true
	%Obstacle3.visible = false
	%Obstacle4.visible = true


func _on_first_area_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		match current_state:
			"first_loop":
				%Obstacle1.visible = true
				%Obstacle3.visible = true


func _on_second_area_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		match current_state:
			"first_loop":
				%Obstacle4.visible = false
				%Obstacle2.visible = false


func _on_third_area_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		match current_state:
			"first_loop":
				%Obstacle3.visible = false


func _on_fourth_area_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		match current_state:
			"first_loop":
				%Obstacle4.visible = true
				%Obstacle2.visible = true
