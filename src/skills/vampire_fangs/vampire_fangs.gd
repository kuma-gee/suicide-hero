class_name VampireFangs

var multiplier := Multiplier.new()
var _res: SpikedGlovesUpgradeResource

func apply(res: VampireFangsUpgradeResource)
	_res = res
	multiplier.life_steal = res.life_steal

func apply_player(player: Player):
	player.add_multiplier(SkillManager.Skill.VAMPIRE_FANGS, multipler)

func get_resource():
	return _res
