class_name SkillManager
extends Node2D

signal weapons_updated(weapons)

enum Type {
	WEAPON,
	ITEM
}

enum Skill {
	BOW,
	AIR_GUST,
	SPIKE_THROW,
	KNIFE_CIRCLE,
	STATS
}

@export var max_weapons := 4
@export var max_items := 4

var _current_skills = {}

var _logger = Logger.new("SkillManager")

func _ready():
	Events.skill_selected.connect(apply)

func apply(skill: UpgradeResource):
	for child in get_children():
		if child.has_method("apply"):
			child.apply(skill)


func get_random_skills(count: int):
	var skills = get_children()
	skills.shuffle()
	
	var result = []
	for skill in skills:
		if skill.has_method("get_upgrade"):
			var upgrade = skill.get_upgrade()
			if upgrade:
				result.append(upgrade)
		
			if result.size() >= count:
				break
	
	return result

func get_active_skills():
	var result = []
	for child in get_children():
		if child.upgrader.resource != null:
			result.append(child)
	
	return result
