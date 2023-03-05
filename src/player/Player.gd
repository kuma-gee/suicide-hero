class_name Player extends CharacterBody2D

signal level_up(lvl)
signal died()

@onready var input := $PlayerInput
@onready var gun_point_root := $GunPointRoot
@onready var state_machine := $StateMachine

@onready var aim_direction := $AimDirection
@onready var move := $StateMachine/Move2D
@onready var knockback_state := $StateMachine/Knockback2D

@onready var stats := $SkillManager/PlayerStats
@onready var sprite := $Body/Sprite
@onready var anim := $AnimationPlayer

@onready var pickup_sound := $PickupArea/PickupSound
@onready var level_up_sound := $LevelUpSound

@onready var heal_particles := $HealParticles
@onready var hp_bar: ValueFillBar = $HpBar

@onready var skill_manager: SkillManager = $SkillManager

var _logger = Logger.new("Player")

func _ready():
	hp_bar.connect_value_fill(stats.health)

func _process(_delta):
	move.motion = _get_motion().normalized()
	move.look_dir = _get_look_direction()
	
	var gun_point = gun_point_root.global_position + move.look_dir
	gun_point_root.look_at(gun_point)


func _get_motion() -> Vector2:
	return Vector2(
		input.get_action_strength("move_right") - input.get_action_strength("move_left"),
		input.get_action_strength("move_down") - input.get_action_strength("move_up")
	)

func _get_look_direction() -> Vector2:
	return aim_direction.get_aim_direction(self)

func get_level():
	return stats.level

func get_stats() -> PlayerResource:
	return stats.player_res

func get_current_health() -> int:
	return stats.health.value

func heal(hp):
	stats.health.increase(hp)
	heal_particles.restart()
	heal_particles.emitting = true


func _on_Knockback2D_knockback_finished():
	state_machine.transition(move)


func _on_PickupArea_area_entered(_area):
	pickup_sound.play()
	_area.pickup(self)


func _on_PlayerStats_level_up(lvl):
	level_up.emit(lvl)
	level_up_sound.play()
	
	var skills = skill_manager.get_random_skills(3)
	_logger.info("Random skills: %s" % [skills])
	GUI.open({"menu": GUI.SkillSelect, "skills": skills})


func _on_Health_zero_value():
	emit_signal("died")


func _on_hurt_box_damaged(dmg):
	stats.health.reduce(dmg)


func _on_hurt_box_knockback(knockback):
	pass
	#state_machine.transition(knockback_state, {"knockback": knockback})

