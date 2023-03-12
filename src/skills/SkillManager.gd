extends Node

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

const SKILL_NODE_MAP = {
	Skill.BOW: preload("res://src/skills/bow/bow.tscn"),
	Skill.AIR_GUST: preload("res://src/skills/air_gust/air_gust.tscn"),
	Skill.SPIKE_THROW: preload("res://src/skills/spike/spike_throw.tscn"),
	Skill.KNIFE_CIRCLE: preload("res://src/skills/knife_circle/knife_circle.tscn")
}

# TODO: autoload class

@export var max_weapons := 4
@export var max_items := 4

@export var _skill_pool: Array[UpgradeResource] = []

var _current_skills = {}
var _skill_nodes = {}

var _logger = Logger.new("SkillManager")

func _ready():
	Events.skill_selected.connect(apply)

func apply(res: UpgradeResource):
	if res is BowUpgradeResource:
		_upgrade_skill(Skill.BOW, res)
	elif res is AirGustUpgradeResource:
		_upgrade_skill(Skill.AIR_GUST, res)
	elif res is SpikeUpgradeResource:
		_upgrade_skill(Skill.SPIKE_THROW, res)
	elif res is KnifeUpgradeResource:
		_upgrade_skill(Skill.KNIFE_CIRCLE, res)
	elif res is StatUpgradeResource:
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

	_update_weapons_changed()
	
	_skill_pool.erase(res)
	if res.next_upgrade:
		if res.next_upgrade.description.icon == null:
			res.next_upgrade.description.icon = res.description.icon
		_skill_pool.append(res.next_upgrade)

func _update_weapons_changed():
	weapons_updated.emit(_current_skills.keys())


func show_next_skills():
	var skills = _get_random_skills(3)
	if skills.size() > 0:
		GUI.open({"menu": GUI.SkillSelect, "skills": skills})
	else:
		_logger.warn("No more skills to get")


func _get_random_skills(count: int):
	_skill_pool.shuffle()
	return _skill_pool.slice(0, count)
