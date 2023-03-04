class_name SkillSelectItem
extends Button

@export var texture: TextureRect
@export var name_label: Label
@export var desc_label: Label

func set_description(res: SkillDescriptionResource):
	texture.texture = res.icon
	name_label.text = tr(res.name)
	desc_label.text = tr(res.text)
