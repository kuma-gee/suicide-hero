extends CanvasLayer

@export var experience: ProgressBar
@export var level: Label
@export var skills: Container

const skill_count := preload("res://src/scenes/main/SkillCount.tscn")

func skill_updated(skill: int, count: int) -> void:
	var node_name = str(skill)
	if not skills.has_node(node_name):
		var node = skill_count.instantiate()
		node.name = node_name
		node.skill = skill
		skills.add_child(node)
	
	var skill_node = skills.get_node(node_name)
	skill_node.set_count(count)

func connect_player_stats(stats: PlayerStats) -> void:
	set_level(stats.level)
	stats.connect("level_up", set_level)
	
	experience.connect_value_fill(stats.experience)

func set_level(lvl: int) -> void:
	print(lvl)
	level.text = tr("LEVEL") + " " + str(lvl)
