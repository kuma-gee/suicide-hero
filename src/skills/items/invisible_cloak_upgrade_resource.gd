class_name InvisibleCloakUpgradeResource
extends UpgradeResource

@export var dodge_chance := 0.1

func get_skill():
	return SkillManager.Skill.INVISIBLE_CLOAK