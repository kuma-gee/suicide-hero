class_name Skill extends Node

enum Type {
	HEALTH,
	SPEED,
	STRENGTH,
}

export(Type) var type: int
export var max_used := -1
export var start_level := 1

func apply(player: Player) -> void:
	pass
