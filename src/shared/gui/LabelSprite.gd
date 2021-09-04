extends Control

onready var _label := $PanelContainer/MarginContainer/Label
onready var _texture_rect := $MarginContainer/TextureRect

onready var _label_container := $PanelContainer
onready var _rect_container := $MarginContainer

func set_label(t: String):
	if t.begins_with("res://"):
		_texture_rect.texture = load(t)
		_label_container.hide()
		_rect_container.show()
	else:
		_label.text = t
		_label_container.show()
		_rect_container.hide()
