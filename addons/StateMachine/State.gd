class_name State extends Node

onready var state_machine: StateMachine = _get_state_machine(self)

func _get_state_machine(node: Node) -> Node:
	if node != null and not node is StateMachine:
		return _get_state_machine(node.get_parent())
	return node


func handle_input(_event: InputEvent) -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass


func enter() -> void:
	pass


func exit() -> void:
	pass
