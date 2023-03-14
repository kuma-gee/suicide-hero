class StatUp
extends Node

var multiplier = Multiplier.new()

func apply(res: StatUpgradeResource):
	multiplier.health += stat.health
	multiplier.attack += stat.attack
	multiplier.attack_speed += stat.attack_speed
	multiplier.move_speed += stat.speed
	multiplier.pickup += stat.pickup


func apply_player(player: Player):
	player.add_multiplier(SkillManager.Skill.STATS, multiplier)