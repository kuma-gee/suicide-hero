class_name Move extends State

signal running
signal idle

export var character_path: NodePath
onready var character: Character = get_node(character_path)

var velocity = Vector2.ZERO

func enter(msg = {}):
	velocity = Vector2.ZERO
	emit_signal("idle")

func physics_process(delta: float):
	var speed = character.stats.get_speed()
	var acceleration = speed * 3
	var friction = speed * 4
	
	var dir = character.ctrl.get_move_direction()
	var accel = acceleration if dir.length() > 0.01 else friction
	velocity = velocity.move_toward(dir * speed, accel  * delta)
	
	character.move(velocity)
		
	if velocity.length() > 0.01:
		emit_signal("running")
	else:
		emit_signal("idle")

	velocity = character.move_and_slide(velocity)
