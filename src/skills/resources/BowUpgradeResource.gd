class_name BowUpgradeResource
extends UpgradeResource

@export var firerate := 1.0
@export var damage := 1.0
@export var count := 1
@export var pierce := false
@export var knockback_force = 0

func get_type():
	return UpgradeResource.Skill.BOW
