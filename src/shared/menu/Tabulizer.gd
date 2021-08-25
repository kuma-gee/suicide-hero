extends Control

export var size := 100

func _ready():
	for child in get_children():
		if child.get_child_count() > 0:
			var first_child: Control = child.get_child(0)
			first_child.rect_min_size.x = size
