extends Control

onready var label := $Label

func _ready():
	label.text = "WASD - " + tr("MOVE") + "\n" + tr("LEFT_MOUSE") + " - " + tr("INPUT_FIRE")
