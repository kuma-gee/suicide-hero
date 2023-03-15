class_name StatUp

var multiplier = Multiplier.new()

func apply(stat: StatUpgradeResource):
	multiplier.health += stat.health
	multiplier.attack += stat.attack
	multiplier.attack_speed += stat.attack_speed
	multiplier.move_speed += stat.speed
	multiplier.pickup += stat.pickup
	multiplier.crit_chance += stat.crit


func apply_player(player: Player):
	player.add_multiplier(SkillManager.Skill.STATS, multiplier)
