extends Node

@export var hit_label: PackedScene

func show_hit(dmg: int, is_crit: bool, pos: Vector2):
	var label = hit_label.instantiate()
	label.is_crit = is_crit
	label.position = pos
	label.set_label(dmg)
	get_tree().current_scene.add_child(label)

func show_miss(pos: Vector2):
	var label = hit_label.instantiate()
	label.position = pos
	label.set_miss()
	get_tree().current_scene.add_child(label)
