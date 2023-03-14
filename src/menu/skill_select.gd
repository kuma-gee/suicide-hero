extends PausedMenu

@export var container: Control
@export var select_item: PackedScene

var _logger = Logger.new("SkillSelect")

func init(data) -> void:
	if "skills" in data:
		var skills = data["skills"] as Array[UpgradeResource]
		for skill in skills:
			var skill_node = select_item.instantiate() as SkillSelectItem
			
			if skill.description == null:
				_logger.debug("Empty description for %s" % skill.resource_path)
			
			skill_node.set_description(skill.description)
			skill_node.pressed.connect(func(): _on_skill_select(skill))
			container.add_child(skill_node)


func _on_skill_select(skill: UpgradeResource):
	if skill.description:
		_logger.info("Selected skill %s" % skill.description.name)
	Events.skill_selected.emit(skill)
	GUI.clear()
