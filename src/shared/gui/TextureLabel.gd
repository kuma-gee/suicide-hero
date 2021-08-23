extends CenterContainer

onready var _tex := $TextureRect
onready var _label := $MarginContainer/PanelContainer/MarginContainer/Label

func set_texture(tex):
	_tex.texture = tex

func set_label(t):
	_label.text = str(t)
