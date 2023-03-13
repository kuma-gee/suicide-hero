extends Node

signal weapons_updated(weapons)
signal items_updated(items)

enum Type {
	WEAPON,
	ITEM,
}

enum Skill {
	BOW,
	AIR_GUST,
	SPIKE_THROW,
	KNIFE_CIRCLE,

	SPIKED_GLOVES,
	VAMPIRE_FANGS,

	STATS
}

const SKILL_NODE_MAP = {
	Skill.BOW: preload("res://src/skills/bow/bow.tscn"),
	Skill.AIR_GUST: preload("res://src/skills/air_gust/air_gust.tscn"),
	Skill.SPIKE_THROW: preload("res://src/skills/spike/spike_throw.tscn"),
	Skill.KNIFE_CIRCLE: preload("res://src/skills/knife_circle/knife_circle.tscn")
}

const WEAPON_TYPES = [
	Skill.BOW,
	Skill.AIR_GUST,
	Skill.SPIKE_THROW,
	Skill.KNIFE_CIRCLE,
]

const ITEM_TYPES = [
	Skill.SPIKED_GLOVES,
	Skill.VAMPIRE_FANGS,
]

@export var max_weapons := 4
@export var max_items := 4

@export var _skill_pool: Array[UpgradeResource] = []

var _current_skills = {}
var _skill_nodes = {}

var _logger = Logger.new("SkillManager")

func _ready():
	Events.skill_selected.connect(apply)

func apply(res: UpgradeResource):
	var type = res.get_type()
	if type != Skill.STATS:
		_upgrade_skill(type, res)
	else:
		var player = get_tree().get_first_node_in_group("Player")
		player.apply(res)
	
func _upgrade_skill(skill: int, res: UpgradeResource):
	if not skill in _skill_nodes:
		if skill in SKILL_NODE_MAP:
			var skill_node = SKILL_NODE_MAP[skill].instantiate()
			var player = get_tree().get_first_node_in_group("Player")
			player.add_skill(skill_node)
			if "player" in skill_node:
				skill_node.player = player
			_skill_nodes[skill] = skill_node
		else:
			_logger.warn("No skill node for %s" % Skill.find_key(skill))
			return


	_skill_nodes[skill].apply(res)
	
	if not skill in _current_skills:
		_current_skills[skill] = 0
	_current_skills[skill] += 1

	_update_skills_changed()
	
	_skill_pool.erase(res)
	if res.next_upgrade:
		if res.next_upgrade.description.icon == null:
			res.next_upgrade.description.icon = res.description.icon
		_skill_pool.append(res.next_upgrade)

func _update_skills_changed():
	weapons_updated.emit(_active_weapons())
	items_updated.emit(_active_items())


func show_next_skills():
	var skills = _get_random_skills(3)
	if skills.size() > 0:
		GUI.open({"menu": GUI.SkillSelect, "skills": skills})
	else:
		_logger.warn("No more skills to get")


func _get_random_skills(count: int):
	var skills = _available_skills()
	skills.shuffle()
	return skills.slice(0, count)

func _available_skills():
	var result = []
	for skill in _skill_pool:
		if _active_weapons().size() >= max_weapons and _is_weapon_type(skill):
			continue

		if _active_items().size() >= max_items and _is_item_type(skill):
			continue
		
		result.append(skilll)
	return skill

func is_weapon_type(res: UpgradeResource):
	return res.get_skill() in WEAPON_TYPES

func is_item_type(res: UpgradeResource):
	return res.get_type() in ITEM_TYPES

func _active_weapons():
	var result = []
	for x in _current_skills.keys():
		if x in WEAPON_TYPES:
			result.append(x)
	return result

func _active_items():
	var result = []
	for x in _current_skills.keys():
		if x in ITEM_TYPES:
			result.append(x)
	return result