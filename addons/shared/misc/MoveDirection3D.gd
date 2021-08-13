class_name MoveDirection3D extends Node

export var speed = 40
export var weight = 0.0

export var move_object_path: NodePath
onready var move_object: Spatial = get_node(move_object_path) if move_object_path else owner

onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity") * ProjectSettings.get_setting("physics/3d/default_gravity_vector")

var vertical_velocity = Vector3.ZERO

func _physics_process(delta):
	var forward_dir = move_object.global_transform.basis.z.normalized() * speed
	vertical_velocity += gravity * weight * delta
	forward_dir += vertical_velocity
	
	move_object.global_translate(forward_dir * delta)
