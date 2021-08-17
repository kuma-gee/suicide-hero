class_name SkillSelectItem extends Node2D

signal auto_selected

var texture: Texture
var key: InputEvent

onready var sprite := $Sprite
onready var label := $CenterContainer/MarginContainer/Label
onready var container := $CenterContainer
onready var timer := $CircleTimer

func _ready():
	sprite.texture = texture
	if key != null:
		label.text = key.as_text()
	
	timer.connect("timeout", self, "_auto_select")

func start_autoselect():
	timer.start()

func _auto_select():
	emit_signal("auto_selected")
