extends Node

var fire = false

func _process(delta):
	if not fire: return
	
	for child in get_children():
		child.fire()

func start_fire():
	fire = true
