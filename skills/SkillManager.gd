extends Node

export var player_path: NodePath
onready var player: Player = get_node(player_path) if player_path else null

var skills = {}

func _ready():
	for child in get_children():
		var skill: Skill = child
		skill.name = str(skill.type)


func add_skill(skill: int) -> void:
	if not skills.has(skill):
		skills[skill] = 0
	
	skills[skill] += 1
	var skill_node = get_node(str(skill))
	if skill_node:
		skill_node.apply(player)


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
		result.append(child.type)
	return result
