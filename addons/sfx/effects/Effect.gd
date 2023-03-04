class_name Effect
extends Node

signal started()
signal finished()

@export var start := false
@export var delay := 0.0
@export var duration := 1.0

@export var node_path: NodePath
@onready var node: Node = get_node(node_path) if node_path else owner

var tween: Tween

func _ready():
	if start:
		start_effect()
	
func _finished():
	emit_signal("finished")

func _started():
	emit_signal("started")

func start_effect():
	if tween:
		tween.kill()
	tween = get_tree().create_tween()
	tween.finished.connect(_finished)
	apply_tween(tween)
	tween.play()
	_started()

func apply_tween(tween: Tween):
	pass

func interpolate_property(tween: Tween, property: String, initial, final) -> void:
	tween.tween_property(node, property, final, duration) \
		.from(initial) \
		.set_delay(delay) \
		.set_ease(Tween.EASE_IN_OUT) \
		.set_trans(Tween.TRANS_QUAD)

	node.set(property, initial)
