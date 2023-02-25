extends Control

const label_sprite = preload("res://src/shared/gui/LabelSprite.tscn")

#@onready var label := $Label

func _ready():
	var profile = InputManager.get_profile()
#	label.text = tr("MOVE") + " - "
#
#	var move_events = []
#	for action in ["move_up", "move_left", "move_right", "move_down"]:
#		var ev = InputManager.get_event(action)
#		move_events.append(InputManager.as_text(ev))
#
#	label.text += "%s, %s, %s, %s" % move_events
#
#	var fire_event = InputManager.get_event("fire")
#	label.text += "\n" + tr("FIRE") + " - " + InputManager.as_text(fire_event)
