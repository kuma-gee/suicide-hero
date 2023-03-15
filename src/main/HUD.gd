extends CanvasLayer

@export var experience: TextureProgressBar
@export var hp_bar: TextureProgressBar
@export var level: Label
@export var hp_label: Label
@export var kill_label: Label

@export var unknown_icon: Texture2D
@export var weapon_container: Control
@export var item_container: Control

const WEAPON_SLOT = preload("res://src/main/weapon_slot.tscn")
const ITEM_SLOT = preload("res://src/main/item_slot.tscn")

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
	SkillManager.weapons_updated.connect(func(x): _set_skill_icons(x, weapon_container))
	for i in range(0, SkillManager.max_weapons):
		var slot = WEAPON_SLOT.instantiate()
		weapon_container.add_child(slot)

	SkillManager.items_updated.connect(func(x): _set_skill_icons(x, item_container))
	for i in range(0, SkillManager.max_items):
		var slot = ITEM_SLOT.instantiate()
		item_container.add_child(slot)

func _set_skill_icons(skills: Array, container: Control):
	for i in range(0, skills.size()):
		var desc = SkillManager.get_active_description(skills[i])
		var icon = container.get_child(i) as SkillSlot
		if icon:
			var tex = desc.icon if desc else unknown_icon
			icon.set_icon(tex)

func update_kills(kills: int):
	kill_label.text = "%s" % kills
