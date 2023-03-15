class_name VampireFangsUpgradeResource
extends UpgradeResource

@export var life_steal := 0.05

func get_skill():
	return SkillManager.Skill.VAMPIRE_FANGS