extends Control

onready var label := $Label

func _ready():
	label.text = tr("MOVE") + " - "
	
	var move_events = []
	for action in ["move_up", "move_left", "move_right", "move_down"]:
		var ev = InputAction.get_event(action)
		move_events.append(InputAction.as_text(ev))
	
	label.text += "%s, %s, %s, %s" % move_events
	
	var fire_event = InputAction.get_event("fire")
	label.text += "\n" + tr("FIRE") + " - " + InputAction.as_text(fire_event)
