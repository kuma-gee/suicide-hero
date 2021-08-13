class_name StateMachine extends Node

onready var body: KinematicBody = owner


export var initial_state: NodePath
onready var state = get_node(initial_state) if initial_state else null

var input: PlayerController

func _ready() -> void:
	yield(owner, "ready")
	state.enter()


func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)


func _process(delta: float) -> void:
	state.update(delta)


func _physics_process(delta: float) -> void:
	state.physics_update(delta)


func transition(new_state) -> void:
	state.exit()
	state = new_state
	state.enter()
