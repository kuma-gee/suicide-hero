extends CanvasLayer

@export var experience: TextureProgressBar
@export var hp_bar: TextureProgressBar
@export var level: Label
@export var hp_label: Label
@export var kill_label: Label

@export var unknown_icon: Texture2D
@export var weapon_container: Control

const WEAPON_SLOT = preload("res://src/scenes/menu/weapon_slot.tscn")

const SKILL_SPRITE_MAP = {
	SkillManager.Skill.BOW: preload("res://assets/ui/Skill_Bow_0.png"),
	SkillManager.Skill.AIR_GUST: null, # TODO: get from skill description
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
	hp_bar.changed.connect(func(): _update_hp_label(stats.health))

func _update_hp_label(value: ValueFill):
	hp_label.text = "%s / %s" % [floor(value.value), value.max_value]

func _set_level(lvl: int) -> void:
	level.text = "LV %s" % lvl

func connect_skill_stats() -> void:
	SkillManager.weapons_updated.connect(_set_weapons)
	for i in range(0, SkillManager.max_weapons):
		var slot = WEAPON_SLOT.instantiate()
		weapon_container.add_child(slot)

func _set_weapons(weapons: Array):
	for i in range(0, weapons.size()):
		var tex = SKILL_SPRITE_MAP[weapons[i]]
		var icon = weapon_container.get_child(i)
		if icon:
			icon.set_icon(tex if tex else unknown_icon)

func update_kills(kills: int):
	kill_label.text = "%s" % kills
