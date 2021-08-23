class_name Effect extends Node

signal started()
signal finished()

export var start := false
export var delay := 0.0
export var duration := 1.0

export var node_path: NodePath
onready var node: Node = get_node(node_path) if node_path else owner

var tween: Tween

func _ready():
	tween = Tween.new()
	add_child(tween)
	tween.connect("tween_all_completed", self, "_finished")
	tween.connect("tween_started", self, "_started")
	
	if start:
		start()
	
func _finished():
	emit_signal("finished")

func _started(obj, key):
	emit_signal("started")

func start():
	apply_tween(tween)
	tween.start()

func apply_tween(tween: Tween):
	pass

func interpolate_property(tween: Tween, property: String, initial, final) -> void:
	tween.interpolate_property(node, property, initial, final, duration, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, delay)
