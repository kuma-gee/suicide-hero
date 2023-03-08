extends Label

@export var color: Color
@export var move_speed := 50
@export var angle_diff := 30.0

@onready var rand_angle = randf_range(-angle_diff, angle_diff)

func _ready():
	modulate = color

func _process(delta):
	var dir = Vector2.UP
	position += dir.rotated(deg_to_rad(rand_angle)) * move_speed * delta

func set_label(dmg: int):
	text = str(dmg)

func _on_life_time_timeout():
	queue_free()
