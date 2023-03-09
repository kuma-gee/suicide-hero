extends CanvasLayer

@export var experience: ProgressBar
@export var level: Label

@export var default_weapon_icon: Texture2D
@export var weapon_icons: Container
#@export var items: Container

#const skill_count := preload("res://src/scenes/main/SkillCount.tscn")

const SKILL_SPRITE_MAP = {
	SkillManager.Skill.BOW: null,
	SkillManager.Skill.AIR_GUST: null,
	SkillManager.Skill.KNIFE_CIRCLE: null,
	SkillManager.Skill.SPIKE_THROW: null,
}

#func skill_updated(skill: int, count: int) -> void:
#	var node_name = str(skill)
#	if not skills.has_node(node_name):
#		var node = skill_count.instantiate()
#		node.name = node_name
#		node.skill = skill
#		skills.add_child(node)
#
#	var skill_node = skills.get_node(node_name)
#	skill_node.set_count(count)

func connect_player_stats(stats: PlayerStats) -> void:
	_set_level(stats.level)
	stats.connect("level_up", _set_level)
	experience.connect_value_fill(stats.experience)

func _set_level(lvl: int) -> void:
	level.text = " " + tr("LEVEL") + " " + str(lvl)

func connect_skill_stats(skill_manager: SkillManager) -> void:
	skill_manager.weapons_updated.connect(_set_weapons)

func _set_weapons(weapons: Array[int]):
	for i in range(0, weapons.size()):
		var icon = weapon_icons.get_child(i) as TextureRect
		var tex = SKILL_SPRITE_MAP[weapons[i]]
		icon.texture = tex or default_weapon_icon
