class_name InvisibleCloak

var _multiplier = Multiplier.new()
var _res: InvisibleCloakUpgradeResource

func apply(res: InvisibleCloakUpgradeResource):
	_res = res
	_multiplier.dodge_chance = res.dodge_chance

func apply_player(player: Player):
	player.add_multiplier(SkillManager.Skill.INVISIBLE_CLOAK, _multiplier)
