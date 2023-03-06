class_name Skill extends Node2D

@export var type := SkillResource.Type.STAT_UP

func get_upgrade():
	return null

func apply(_res: UpgradeResource) -> void:
	pass

func activate(_player: PlayerResource) -> void:
    pass