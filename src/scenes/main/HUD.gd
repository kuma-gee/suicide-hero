extends CanvasLayer

onready var health := $Root/Bottom/PanelContainer/MarginContainer/VBoxContainer/GridContainer/HealthBar
onready var experience := $Root/Bottom/PanelContainer/MarginContainer/VBoxContainer/GridContainer/ExpBar
onready var level := $Root/Bottom/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Level
onready var skills := $Root/Top/MarginContainer/SkillsContainer

const skill_count := preload("res://src/scenes/main/SkillCount.tscn")

func skill_updated(skill: int, count: int) -> void:
	var node_name = str(skill)
	if not skills.has_node(node_name):
		var node = skill_count.instance()
		node.name = node_name
		node.skill = skill
		skills.add_child(node)
	
	var skill_node = skills.get_node(node_name)
	skill_node.set_count(count)

func connect_player_stats(stats: PlayerStats) -> void:
	set_level(stats.level)
	var _x = stats.connect("level_up", self, "set_level")
	
	health.connect_value_fill(stats.health)
	experience.connect_value_fill(stats.experience)

func set_level(lvl: int) -> void:
	level.text = tr("LEVEL") + ": " + str(lvl)
