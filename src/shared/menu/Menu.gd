extends Control

class_name Menu

export var focus_node_path: NodePath
onready var focus_node := get_node(focus_node_path) if focus_node_path else null

func _ready():
	focus()

func focus():
	if focus_node:
		focus_node.grab_focus()
	else:
		_focus_first()

func _focus_first():
	if get_child_count() > 0:
		get_child(0).grab_focus()
		
