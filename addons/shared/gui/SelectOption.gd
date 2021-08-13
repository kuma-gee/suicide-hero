extends Node

class_name SelectOption

export var text = ""

func _ready():
	var options = get_parent()
	if options is OptionButton:
		options.add_item(text)
