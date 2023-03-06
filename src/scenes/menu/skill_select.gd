extends PausedMenu

@export var container: Control
@export var empty_desc: SkillDescriptionResource
@export var select_item: PackedScene

var _logger = Logger.new("SkillSelect")

func init(data) -> void:
	if "skills" in data:
		var skills = data["skills"] as Array[UpgradeResource]
		for skill in skills:
			var skill_node = select_item.instantiate() as SkillSelectItem
			skill_node.set_description(skill.description if skill.description else empty_desc)
			skill_node.pressed.connect(func(): _on_skill_select(skill))
			container.add_child(skill_node)
	
	


func _on_skill_select(skill: UpgradeResource):
	_logger.info("Selected skill %s" % skill)
	Events.skill_selected.emit(skill)
	GUI.clear()
