class_name Player extends KinematicBody2D

signal skill_selected(skill)
signal damaged(dmg)

onready var input := $PlayerInput
onready var gun_point_root := $GunPointRoot
onready var gun_fire_rate := $GunPointRoot/FireRate
onready var state_machine := $StateMachine

onready var move := $StateMachine/Move2D
onready var knockback_state := $StateMachine/Knockback2D
onready var skill_select := $SkillSelect

onready var stats := $PlayerStats
onready var sprite := $Body/Sprite
onready var anim := $AnimationPlayer
onready var magnet := $PickupMagnet/CollisionShape2D

onready var pickup_sound := $PickupArea/PickupSound
onready var hit_sound := $HurtBox/HitSound

onready var heal_particles := $HealParticles

const LEVEL_UP = preload("res://player/LevelUp.tscn")
const level_up_img = preload("res://player/lvl-up.png")

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
	heal_particles.emitting = true

func increase_damage(dmg) -> void:
	gun_point_root.damage_increase += dmg

func increase_speed(speed) -> void:
	move.speed += speed

func increase_magnet(size) -> void:
	var circle = magnet.shape as CircleShape2D
	circle.radius += size

func enable_homing() -> void:
	gun_point_root.homing = true

func increase_firerate(decrease: float) -> void:
	gun_fire_rate.wait_time -= decrease

func level_up() -> void:
	show_gain(level_up_img)

func _on_Knockback2D_knockback_finished():
	state_machine.transition(move)


func _on_HurtBox_knockback(knockback):
	state_machine.transition(knockback_state, {"knockback": knockback})


func _on_HurtBox_damaged(dmg):
	stats.health.reduce(dmg)
	sprite.modulate.a = 0.75
	hit_sound.play()

func show_gain(texture: Texture) -> void:
	var node = LEVEL_UP.instance()
	skill_select.add_child(node)
	node.set_texture(texture)

func skills(skill1: int, skill2: int):
	skill_select.select_skills(skill1, skill2)


func _on_SkillSelect_skill_selected(skill):
	emit_signal("skill_selected", skill)
	show_gain(Skill.skill_map[skill])


func _on_HurtBox_invincibility_timeout():
	sprite.modulate.a = 1


func _on_PickupArea_area_entered(area):
	pickup_sound.play()
