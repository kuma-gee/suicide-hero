extends Control

export var next_scene: PackedScene


func _on_FadeOut_finished():
	get_tree().change_scene_to(next_scene)
