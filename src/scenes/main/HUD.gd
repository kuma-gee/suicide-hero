extends CanvasLayer

@export var experience: TextureProgressBar
@export var hp_bar: TextureProgressBar
@export var level: Label
@export var hp_label: Label

@export var default_weapon_icon: Texture2D

@export var weapon_icons: Array[NodePath]

const SKILL_SPRITE_MAP = {
	SkillManager.Skill.BOW: preload("res://assets/ui/Skill_Bow_0.png"),
	SkillManager.Skill.AIR_GUST: null,
	SkillManager.Skill.KNIFE_CIRCLE: null,
	SkillManager.Skill.SPIKE_THROW: null,
}

func _ready():
	connect_skill_stats()
	
func connect_player_stats(stats: PlayerStats) -> void:
	_set_level(stats.level)
	stats.connect("level_up", _set_level)
	experience.connect_value_fill(stats.experience)
	hp_bar.connect_value_fill(stats.health)
	hp_bar.changed.connect(func(): hp_label.text = "%s / %s" % [hp_bar.value, hp_bar.max_value])

func _set_level(lvl: int) -> void:
	level.text = tr("LEVEL") + " " + str(lvl)

func connect_skill_stats() -> void:
	SkillManager.weapons_updated.connect(_set_weapons)

func _set_weapons(weapons: Array):
	for i in range(0, weapons.size()):
		var tex = SKILL_SPRITE_MAP[weapons[i]]
		var icon = get_node(weapon_icons[i])
		if icon:
			icon.texture = tex if tex else default_weapon_icon
