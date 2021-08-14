extends KinematicBody2D

export var speed := 200
export var acceleration := 600
export var friction := 800

onready var input := $PlayerInput
onready var body := $Body
onready var bullet_spawner := $BulletSpawner

var velocity = Vector2.ZERO

func _process(delta):
	bullet_spawner.spawn = input.is_pressed("fire")

func _physics_process(delta: float):
	var dir = _get_motion()
	var accel = acceleration if dir.length() > 0.01 else friction
	velocity = velocity.move_toward(dir * speed, accel  * delta)
	
	_move(velocity)
	
	velocity = move_and_slide(velocity)

func _get_motion() -> Vector2:
	return Vector2(
		input.get_action_strength("move_right") - input.get_action_strength("move_left"),
		input.get_action_strength("move_down") - input.get_action_strength("move_up")
	)

func _move(velocity: Vector2) -> void:
	var look_dir = _get_look_direction(self)
	var scale_x = 1
	
	if look_dir.x < 0:
		scale_x = -1
		
	body.scale.x = scale_x

func _get_look_direction(node: Node2D) -> Vector2:
	var mouse_pos = node.get_global_mouse_position()
	return node.global_position.direction_to(mouse_pos).normalized()
