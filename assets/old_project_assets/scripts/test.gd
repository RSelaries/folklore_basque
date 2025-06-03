@tool
class_name OldCameraManager
extends Control


@onready var scene_3d: Scene3D = %Main


## If you want to go to camera 'HouseSideCamera', [param location_name] should be HouseSide
func _change_location_to(location_name: String) -> void:
	for camera: Camera3D in scene_3d.cameras:
		if camera.name == location_name + "Camera":
			camera.make_current()
			break
	
	for interaction: Control in %InteractionWindows.get_children():
		if interaction.name == location_name + "Interactions":
			interaction.visible = true
		else :
			interaction.visible = false
