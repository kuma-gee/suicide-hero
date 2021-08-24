extends HBoxContainer

export var text := ""

onready var label := $Label
onready var button := $Button

func _ready():
	label.text = text.to_upper()
	button.action = text.to_lower()
