extends OptionButton

func _ready():
	var idx = 0
	for child in get_children():
		if child is SelectOption:
			add_item(child.text, idx)
			set_item_disabled(idx, child.disabled)
			idx += 1


func set_value(text: String) -> void:
	for i in range(0, get_item_count()):
		if text == get_item_text(i):
			selected = i
			return
