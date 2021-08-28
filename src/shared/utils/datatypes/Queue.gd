class_name Queue extends Node

signal dequed(value)

export var auto_deque = false

var values = []

func queue(value) -> void:
	values.append(value)
	
func deque():
	return values.pop_front()

func available() -> bool:
	return values.size() > 0

func _process(_delta):
	if auto_deque and available():
		emit_signal("dequed", deque())
