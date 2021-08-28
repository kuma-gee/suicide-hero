class_name Skill extends Node

enum Type {
	HEALTH,
	SPEED,
	STRENGTH,
	MAGNET,
	HOMING,
	FIRERATE,
}

const skill_map = {
	Type.HEALTH: preload("res://src/skills/hp-up.png"),
	Type.SPEED: preload("res://src/skills/speed-up.png"),
	Type.STRENGTH: preload("res://src/skills/strength-up.png"),
	Type.MAGNET: preload("res://src/skills/pickup-up.png"),
	Type.HOMING: preload("res://src/skills/homing-shots.png"),
	Type.FIRERATE: preload("res://src/skills/shot-up.png"),
}

export var enabled := true
export(Type) var type: int
export var max_used := -1
export var start_level := 1

func apply(_player) -> void:
	pass
