extends Node

class_name MoveDirection2D

export var speed = 1000
export var direction = Vector2.UP

export var move_object_path: NodePath
onready var move_object: Node2D = get_node(move_object_path) if move_object_path else owner

func _physics_process(delta):
	var dir = direction.rotated(move_object.rotation)
	move_object.global_position += dir * delta * speed
