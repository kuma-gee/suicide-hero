#extends State
#
#class_name MoveState
#
#export var JUMP_FORCE := 8.0
#export var DROP_FRICTION := 0.8
#export var DROP_DRAG := 0.85
#export var MAX_GRAVITY := 32.0
#export var MAX_SPEED := 16.0
#export var MAX_ACCEL := 160.0
#
#export var motion_speed := 10.0
#
#var motion = Vector2.ZERO
#var dir = Vector3.ZERO
#var vel = Vector3.ZERO
#var snap = Vector3.DOWN
#
#var body: KinematicBody
#var input: PlayerController
#
#func enter():
#	body = state_machine.body
#	input = state_machine.input
#
#func physics_update(delta: float) -> void:
#	var new_motion = input.get_motion()
#
#	motion = motion.move_toward(new_motion, delta * motion_speed)
#
#	dir += motion.y * body.global_transform.basis.z
#	dir += motion.x * body.global_transform.basis.x
#
#	dir = dir.normalized()
#
#	# Horizontal velocity without gravity
#	var hvel = vel
#	hvel.y = 0
#	var cur_speed : float = hvel.dot(dir)
#
#	# Friction if grounded, drag elsewise
#	var fric = DROP_FRICTION if body.is_on_floor() else DROP_DRAG
#	hvel *= fric
#	if hvel.length() < MAX_SPEED * 0.01:
#		hvel = Vector3.ZERO
#
#	# Acceleration
#	var add_speed : float = clamp(MAX_SPEED - cur_speed, 0.0, MAX_ACCEL * delta)
#	hvel += dir * add_speed
#
#	vel.x = hvel.x
#	vel.z = hvel.z
#	vel = body.move_and_slide_with_snap(vel, snap, Vector3.UP, true, 3, 0.78, false)
#	dir = Vector3.ZERO
#
#
#	if body.is_on_floor():
#		if input.is_jumping():
#			snap = Vector3.ZERO
#			vel.y = JUMP_FORCE
#		else:
#			snap = -body.get_floor_normal()
#	else:
#		snap = Vector3.DOWN
#		var grav = MAX_GRAVITY
#		vel.y -= grav * delta
