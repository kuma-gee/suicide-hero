class_name Multiplier
extends Node

@export var player: Player = owner

func get_attack():
	return 1 + (player.res.attack) + _combine_multiplier("attack")
	
func get_speed():
	return 1 + (player.res.speed) + _combine_multiplier("speed")
	
func _combine_multiplier(method: String):
	var result = 0.0
	for child in get_children():
		if child.has_method(method):
			result += child.call(method)
	return result
