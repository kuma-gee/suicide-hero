extends Control

export var relative_font_size := 1.0
export var spacing := 0.0

func _ready():
	var font := get_font("font").duplicate()
	if relative_font_size != 1.0:
		var size = font.get("size")
		if size:
			font.set("size", size * relative_font_size)
	
	if spacing != 0.0:
		font.set("extra_spacing_top", spacing)
		font.set("extra_spacing_bottom", spacing)

	set("custom_fonts/font", font)
