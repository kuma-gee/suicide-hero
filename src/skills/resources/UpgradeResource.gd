class_name UpgradeResource
extends Resource

enum Skill {
	BOW,
	STAT,
}

@export var description: SkillDescriptionResource

func get_type():
	return null
