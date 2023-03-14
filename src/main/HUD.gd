extends CanvasLayer

@export var experience: TextureProgressBar
@export var hp_bar: TextureProgressBar
@export var level: Label
@export var hp_label: Label
@export var kill_label: Label

@export var unknown_icon: Texture2D
@export var weapon_container: Control
@export var item_container: Control

const WEAPON_SLOT = preload("res://src/scenes/menu/weapon_slot.tscn")

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

	for i in range(0, SkillManager.max_items):
		var slot = WEAPON_SLOT.instantiate()
		item_container.add_child(slot)

func _set_weapons(weapons: Array):
	for i in range(0, weapons.size()):
		var desc = SkillManager.get_active_description(weapons[i])
		var icon = weapon_container.get_child(i)
		if icon:
			var tex = desc.icon if desc else unknown_icon
			icon.set_icon(tex)

func update_kills(kills: int):
	kill_label.text = "%s" % kills
