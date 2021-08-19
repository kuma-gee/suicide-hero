class_name Player extends KinematicBody2D

signal skill_selected(skill)
signal damaged(dmg)

onready var input := $PlayerInput
onready var gun_point_root := $GunPointRoot
onready var state_machine := $StateMachine

onready var move := $StateMachine/Move2D
onready var knockback_state := $StateMachine/Knockback2D
onready var skill_select := $SkillSelect

onready var stats := $PlayerStats
onready var sprite := $Body/Sprite
onready var anim := $AnimationPlayer
onready var magnet := $PickupMagnet/CollisionShape2D

func _process(delta):
	gun_point_root.shoot = input.is_pressed("fire")
	
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
	stats.health.increase(hp)

func increase_damage(dmg) -> void:
	gun_point_root.damage_increase += dmg

func increase_speed(speed) -> void:
	move.speed += speed

func increase_magnet(size) -> void:
	var circle = magnet.shape as CircleShape2D
	circle.radius += size

func _on_Knockback2D_knockback_finished():
	state_machine.transition(move)


func _on_HurtBox_knockback(knockback):
	state_machine.transition(knockback_state, {"knockback": knockback})


func _on_HurtBox_damaged(dmg):
	stats.health.reduce(dmg)
	sprite.modulate.a = 0.75


func skills(skill1: int, skill2: int):
	skill_select.select_skills(skill1, skill2)


func _on_SkillSelect_skill_selected(skill):
	emit_signal("skill_selected", skill)


func _on_HurtBox_invincibility_timeout():
	sprite.modulate.a = 1
