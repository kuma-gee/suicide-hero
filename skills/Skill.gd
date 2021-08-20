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
	Type.HEALTH: preload("res://skills/hp-up.png"),
	Type.SPEED: preload("res://skills/speed-up.png"),
	Type.STRENGTH: preload("res://skills/strength-up.png"),
	Type.MAGNET: preload("res://skills/pickup-up.png"),
	Type.HOMING: preload("res://skills/homing-shots.png"),
	Type.FIRERATE: preload("res://skills/shot-up.png"),
}

export var enabled := true
export(Type) var type: int
export var max_used := -1
export var start_level := 1

func apply(player: Player) -> void:
	pass
