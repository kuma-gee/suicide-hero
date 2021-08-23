class_name SkillSelectItem extends Node2D

signal auto_selected

var texture: Texture
var key: InputEvent

onready var texture_label := $TextureLabel
onready var timer := $TextureLabel/CircleTimer

func _ready():
	texture_label.set_texture(texture)
	if key != null:
		texture_label.set_label(key.as_text())
	
	timer.connect("timeout", self, "_auto_select")

func start_autoselect():
	timer.start()

func _auto_select():
	emit_signal("auto_selected")
