class_name Move2D extends State

export var speed := 200
export var acceleration := 600
export var friction := 800

export var kinematic_body_path: NodePath
onready var kinematic_body: KinematicBody2D = get_node(kinematic_body_path) if kinematic_body_path else owner

export var body_path: NodePath
onready var body := get_node(body_path)

var velocity = Vector2.ZERO
var motion = Vector2.ZERO
var look_dir = Vector2.ZERO

func physics_process(delta: float):
	var dir = motion
	var accel = acceleration if dir.length() > 0.01 else friction
	velocity = velocity.move_toward(dir * speed, accel  * delta)
	
	_move(velocity)
	
	velocity = kinematic_body.move_and_slide(velocity)

func _move(velocity: Vector2) -> void:
	var scale_x = 1
	
	if look_dir.x < 0:
		scale_x = -1
		
	body.scale.x = scale_x
