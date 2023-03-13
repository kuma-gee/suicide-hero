class_name SkillSelectItem
extends BaseButton

@export var texture: TextureRect
@export var name_label: Label
@export var desc_label: Label

@export var default_icon: Texture2D

func set_description(res: SkillDescriptionResource):
	var tex = res.icon if res and res.icon else default_icon
	var n = res.name if res and res.name != "" else "No Name"
	var d = res.text if res and res.text != "" else "Nos Text"
	
	texture.texture = tex
	name_label.text = tr(n)
	desc_label.text = tr(d)
