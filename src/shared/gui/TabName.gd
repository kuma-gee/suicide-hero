extends Tabs

export var text = ""

func _ready():
	name = text

func tab_changed():
	for child in get_children():
		if child is Menu:
			child.focus()
			return
