class_name SkillManager
extends Node

var fire = false
var _player_res: PlayerResource

func _ready():
	Events.skill_selected.connect(apply)

func _process(delta):
	if not fire: return
	
	for child in get_children():
		if child.has_method("activate"):
			child.activate(_player_res)

func start_fire():
	fire = true

func apply(skill: UpgradeResource):
	for child in get_children():
		if child.has_method("apply"):
			child.apply(skill)

func get_random_skills(count: int):
	var skills = get_children()
	skills.shuffle()
	
	var result = []
	for skill in skills:
		var upgrade = skill.get_upgrade()
		if upgrade:
			result.append(upgrade)
		
		if result.size() >= count:
			break
	
	return result


func _on_player_stats_player_stat_changed(res):
	_player_res = res
