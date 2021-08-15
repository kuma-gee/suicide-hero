class_name Knockback2D extends State

signal knockback_start
signal knockback_finished

export var friction := 200

export var body_path: NodePath
onready var body: KinematicBody2D = get_node(body_path) if body_path else owner

var knockback = Vector2.ZERO

func enter(msg := {}) -> void:
	knockback = msg["knockback"]
	emit_signal("knockback_start")

func physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	knockback = body.move_and_slide(knockback)

	if knockback == Vector2.ZERO:
		emit_signal("knockback_finished")
