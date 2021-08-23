class_name MoveToward2D extends Node

export var speed = 300

export var move_object_path: NodePath
onready var move_object: Node2D = get_node(move_object_path) if move_object_path else owner

var target: Node2D
#var velocity: Vector2

func _physics_process(delta):
	if not target: return
	
#	var dir = move_object.global_position.direction_to(target.global_position)
	
#	velocity = velocity.move_toward(dir * speed, accel * delta)
	var dir := move_object.global_position.direction_to(target.global_position)
	dir = dir.normalized()
	
	move_object.global_position += dir * speed * delta
