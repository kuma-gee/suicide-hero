class_name BombUpgradeResource
extends UpgradeResource

@export var firerate := 20.0
@export var throw_force := 300
@export var throw_amount := 1

@export var explosion_radius := 50
@export var damage := 5

func get_skill():
	return SkillManager.Skill.BOMB
