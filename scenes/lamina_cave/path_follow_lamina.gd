extends PathFollow3D


## Starting position in meters/second
@export var speed: float = 2.0


@onready var animation_player: AnimationPlayer = $Laminak2/SubViewport/Lamina/AnimationPlayer


func _ready() -> void:
	animation_player.play("walk_holding")
	animation_player.speed_scale = RandomNumberGenerator.new().randf_range(1.5, 2.5)
	


func _process(delta: float) -> void:
	progress += speed * delta
