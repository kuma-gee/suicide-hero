class_name SmartGlasses

var _multiplier = Multiplier.new()
var _res: SmartGlassesUpgradeResource

func apply(res: SmartGlassesUpgradeResource):
	_res = res
	_multiplier.experience = res.exp_multiplier

func apply_player(player: Player):
	player.add_multiplier(SkillManager.Skill.SMART_GLASSES, _multiplier)

func get_resource():
	return _res
