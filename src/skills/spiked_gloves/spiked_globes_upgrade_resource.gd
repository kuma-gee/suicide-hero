class_name SpikedGlovesUpgradeResource
extends UpgradeResource

@export var damage_received := 0.2
@export var damage_boost := 0.2

func get_skill():
	return SkillManager.Skill.SPIKED_GLOVES