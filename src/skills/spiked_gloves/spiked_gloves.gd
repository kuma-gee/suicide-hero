class_name SpikedGloves
extends Node

var multiplier = Multiplier.new()
var _res: SpikedGlovesUpgradeResource

func apply(res: SpikedGlovesUpgradeResource):
	_res = res
	multiplier.attack = res.damage_boost
	multiplier.damage = res.damage_received


func apply_player(player: Player):
	player.add_multiplier(SkillManager.Skill.SPIKED_GLOVES, multiplier)

func get_resource():
	return _res
