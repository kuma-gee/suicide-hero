class_name StateMachine extends Node

export var initial_state: NodePath
onready var state = get_node(initial_state) if initial_state else null

func _ready() -> void:
	yield(owner, "ready")
	state.enter()


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.process(delta)


func _physics_process(delta: float) -> void:
	state.physics_process(delta)


func transition(new_state, msg := {}) -> void:
	state.exit()
	state = new_state
	state.enter(msg)

func transition_node(node_name: String) -> void:
	if has_node(node_name):
		transition(get_node(node_name))
