class_name Player extends KinematicBody2D

signal heal(hp)
signal damaged(dmg)

onready var input := $PlayerInput
onready var bullet_spawner := $BulletSpawner
onready var state_machine := $StateMachine

onready var move := $StateMachine/Move2D
onready var knockback_state := $StateMachine/Knockback2D

func _process(delta):
	bullet_spawner.spawn = input.is_pressed("fire")
	
	move.motion = _get_motion()
	move.look_dir = _get_look_direction()

func _get_motion() -> Vector2:
	return Vector2(
		input.get_action_strength("move_right") - input.get_action_strength("move_left"),
		input.get_action_strength("move_down") - input.get_action_strength("move_up")
	)

func _get_look_direction() -> Vector2:
	var mouse_pos = get_global_mouse_position()
	return global_position.direction_to(mouse_pos).normalized()

func heal(hp):
	emit_signal("heal", hp)


func _on_Knockback2D_knockback_finished():
	state_machine.transition(move)


func _on_HurtBox_knockback(knockback):
	state_machine.transition(knockback_state, {"knockback": knockback})


func _on_HurtBox_damaged(dmg):
	emit_signal("damaged", dmg)
