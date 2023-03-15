class_name VampireFangs

var _multiplier := Multiplier.new()
var _res: VampireFangsUpgradeResource

func apply(res: VampireFangsUpgradeResource):
	_res = res
	_multiplier.life_steal = res.life_steal

func apply_player(player: Player):
	player.add_multiplier(SkillManager.Skill.VAMPIRE_FANGS, _multiplier)

func get_resource():
	return _res
