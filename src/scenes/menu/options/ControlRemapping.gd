extends Control

export var text = ["move_left", "move_right", "move_up", "move_down", "fire", "skill_1", "skill_2"]

const REMAPPING_ACTION = preload("res://src/scenes/menu/input/RebindableAction.tscn")

func _add_inputs(action: String) -> void:
	var label = Label.new()
	label.text = action
	var button = REMAPPING_ACTION.instance()
	
