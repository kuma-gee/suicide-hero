class_name Upgrader
extends Node

signal upgraded(res)

@export var upgrades: Array[UpgradeResource]
@export var level = -1

var resource: UpgradeResource :
	get: return _get_res_for_lvl(level)


func _get_res_for_lvl(lvl: int):
	if lvl < 0 or lvl >= upgrades.size(): return null
	return upgrades[lvl]

func get_next_upgrade():
	return _get_res_for_lvl(level + 1)

func upgrade():
	level += 1
	upgraded.emit(self.resource)
