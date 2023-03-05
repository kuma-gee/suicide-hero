class_name BowUpgradeResource
extends UpgradeResource

@export var firerate := 0.0
@export var damage := 0.0
@export var count := 0
@export var pierce := false
@export var knockback_force = 0
@export var speed := 0.0

@export var next_upgrade: BowUpgradeResource

func get_type():
	return UpgradeResource.Skill.BOW
