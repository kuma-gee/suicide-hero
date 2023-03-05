extends PausedMenu

@export var container: Control

const ITEM = preload("res://src/scenes/menu/skill_select_item.tscn")
const EMPTY = preload("res://src/skills/resources/EmptyDescription.tres")

var _logger = Logger.new("SkillSelect")

func init(data) -> void:
	if "skills" in data:
		var skills = data["skills"] as Array[UpgradeResource]
		for skill in skills:
			var skill_node = ITEM.instantiate() as SkillSelectItem
			skill_node.set_description(skill.description if skill.description else EMPTY)
			skill_node.pressed.connect(func(): _on_skill_select(skill))
			container.add_child(skill_node)


func _on_skill_select(skill: UpgradeResource):
	_logger.info("Selected skill %s" % skill)
	Events.skill_selected.emit(skill)
	GUI.clear()
