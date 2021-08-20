extends Control

export var relative_font_size := 1.0

func _ready():
	var font = get_font("font").duplicate()
	var size = font.get("size")
	font.set("size", size * relative_font_size)

	set("custom_fonts/font", font)
