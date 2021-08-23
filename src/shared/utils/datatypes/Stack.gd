extends Node

class_name Stack

signal added(value)
signal removed(value)

var stack = []

var current setget ,_get_current

func _get_current():
	if size() <= 0: return null
	return stack[stack.size() - 1]


func pop():
	if size() <= 0: return
	emit_signal("removed", stack.pop_back())


func push(value):
	stack.push_back(value)
	emit_signal("added", value)

func clear():
	stack.clear()

func size():
	return stack.size()
