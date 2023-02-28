extends Node

signal skill_added(skill, skill_count)

var player: Player
var skills = {}

func _ready():
	for child in get_children():
		var skill: Skill = child
		skill.name = str(skill.type)


func add_skill(skill: int) -> void:
	if not skills.has(skill):
		skills[skill] = 0
	
	var skill_node = get_node(str(skill))
	if skill_node:
		skill_node.apply(player)
		skills[skill] += 1
		emit_signal("skill_added", skill, skills[skill])


func get_random_skills(lvl: int) -> Array:
	var available_skills = _get_allowed_skills(lvl)
	if available_skills.size() == 0: return []

	var skill1 = Random.random_int(0, available_skills.size())
	var skill2 = skill1
	if available_skills.size() >= 2:
		while skill2 == skill1:
			skill2 = Random.random_int(0, available_skills.size())

	return [available_skills[skill1], available_skills[skill2]] 
	


func _get_allowed_skills(lvl: int) -> Array:
	var result = []
	for child in get_children():
		var skill: Skill = child
		if skills.has(skill.type) and skills[skill.type] >= skill.max_used:
			remove_child(child)
		elif skill.enabled and lvl >= skill.start_level:
			result.append(child.type)
	return result
