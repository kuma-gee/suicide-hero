extends Control

export var next_scene: PackedScene

onready var tween := $Tween
onready var logo := $Logo

func _ready():
	var start = Color(1, 1, 1, 1)
	var end = Color(1, 1, 1, 0)
	tween.interpolate_property(logo, "modulate", start, end, 1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, 0.5)
	tween.start()


func _on_Tween_tween_all_completed():
	get_tree().change_scene_to(next_scene)
