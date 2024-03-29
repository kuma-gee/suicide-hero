extends Node

signal weapons_updated(weapons)
signal items_updated(items)

enum Type {
	WEAPON,
	ITEM,
}

# Make sure all weapons are in here
const WEAPON_TYPES = [
	Skill.BOW,
	Skill.AIR_GUST,
	Skill.SPIKE_THROW,
	Skill.KNIFE_CIRCLE,
	Skill.BOMB,
]

enum Skill {
	# Weapons
	BOW,
	AIR_GUST,
	SPIKE_THROW,
	KNIFE_CIRCLE,
	BOMB,

	# Passives
	STATS,

	# Items
	SPIKED_GLOVES,
	VAMPIRE_FANGS,
	INVISIBLE_CLOAK,
	SMART_GLASSES,
}

# Make sure all items are in here
const ITEM_TYPES = [
	Skill.SPIKED_GLOVES,
	Skill.VAMPIRE_FANGS,
	Skill.INVISIBLE_CLOAK,
	Skill.SMART_GLASSES,
]

const SKILL_SCENES = {
	Skill.BOW: preload("res://src/skills/weapons/bow.tscn"),
	Skill.AIR_GUST: preload("res://src/skills/weapons/air_gust.tscn"),
	Skill.SPIKE_THROW: preload("res://src/skills/weapons/spike_throw.tscn"),
	Skill.KNIFE_CIRCLE: preload("res://src/skills/weapons/knife_circle.tscn"),
	Skill.BOMB: preload("res://src/skills/weapons/bomb.tscn")
}

@export var max_weapons := 4
@export var max_items := 4

@export var _skill_pool: Array[UpgradeResource] = []

var _pool: Array[UpgradeResource] = []
var _current_skills = {}
var _skill_nodes = {
	Skill.SPIKED_GLOVES: SpikedGloves.new(),
	Skill.VAMPIRE_FANGS: VampireFangs.new(),
	Skill.STATS: StatUp.new(),
	Skill.INVISIBLE_CLOAK: InvisibleCloak.new(),
	Skill.SMART_GLASSES: SmartGlasses.new(),
}

var _logger = Logger.new("SkillManager")

func _ready():
	Events.skill_selected.connect(apply)
	for x in _skill_pool:
		if x: _pool.append(x)

func apply(res: UpgradeResource):
	var type = res.get_skill()
	var player = get_tree().get_first_node_in_group("Player")
	_upgrade_skill(res, player)
	
	# TODO: effect on skill apply

func _upgrade_skill(res: UpgradeResource, player: Player):
	var skill = res.get_skill()
	if not skill in _skill_nodes:
		if skill in SKILL_SCENES:
			var skill_node = SKILL_SCENES[skill].instantiate()
			if "player" in skill_node:
				skill_node.player = player
			player.add_skill(skill_node)
			_skill_nodes[skill] = skill_node
		else:
			_logger.warn("No skill node for %s" % Skill.find_key(skill))
			return

	var node = _skill_nodes[skill]
	node.apply(res)
	if node.has_method("apply_player"):
		node.apply_player(player)

	if not skill in _current_skills:
		_current_skills[skill] = 0
	_current_skills[skill] += 1

	_update_skills_changed()
	
	_pool.erase(res)
	if res.next_upgrade:
		if res.next_upgrade.description.icon == null:
			res.next_upgrade.description.icon = res.description.icon
		_pool.append(res.next_upgrade)


func _update_skills_changed():
	weapons_updated.emit(_active_weapons())
	items_updated.emit(_active_items())

func get_active_description(skill: int):
	if skill in _skill_nodes:
		var node = _skill_nodes[skill]
		if node.has_method("get_resource"):
			return node.get_resource().description

	return null

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
	var weapons = _active_weapons()
	var items = _active_items()
	for res in _pool:
		var s = res.get_skill()
		if not s in weapons and not s in items:
			if weapons.size() >= max_weapons and s in WEAPON_TYPES:
				continue

			if items.size() >= max_items and s in ITEM_TYPES:
				continue
		
		result.append(res)
	return result

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
