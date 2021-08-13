extends OptionButton

func set_value(text: String) -> void:
	for i in range(0, get_item_count()):
		if text == get_item_text(i):
			selected = i
			return
