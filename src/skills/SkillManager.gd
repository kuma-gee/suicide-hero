class_name SkillManager
extends Node2D

enum Type {
	WEAPON,
	ITEM
}

@export var max_weapons := 4
@export var max_items := 4

# var fire = false
var _logger = Logger.new("SkillManager")

func _ready():
	Events.skill_selected.connect(apply)

# func _process(delta):
# 	if not fire: return
	
# 	for child in get_children():
# 		if child.has_method("activate"):
# 			child.activate(_player_res)

# func start_fire():
# 	fire = true

func apply(skill: UpgradeResource):
	_logger.info("Applying %s" % tr(skill.description.name))
	
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
