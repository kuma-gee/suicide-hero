class_name Player extends CharacterBody2D

signal level_up(lvl)
signal died()
signal multiplier_changed()

@export var stats: PlayerStats
@export var initial_skill: UpgradeResource

@onready var input := $PlayerInput
@onready var gun_point_root := $GunPointRoot

@onready var hand := $GunPointRoot/Hand
@onready var aim_direction := $AimDirection
@onready var move := $Move2D

@onready var pickup_magnet := $PickupMagnet
@onready var pickup_sound := $PickupArea/PickupSound
@onready var level_up_sound := $LevelUpSound

var _multiplier := {}

func _ready():
	SkillManager.apply(initial_skill)

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

func get_attack_multiplier() -> float:
	return 1.0 + _combine_multipier("attack")

func get_attack_speed_multiplier() -> float:
	# Firerate has to be reduced
	return 1.0 - _combine_multipier("attack_speed")

func get_move_speed_multiplier() -> float:
	return 1.0 + _combine_multipier("move_speed")

func get_damage_multiplier() -> float:
	return 1.0 + _combine_multipier("damage")

func get_health_multiplier() -> float:
	return 1.0 + _combine_multipier("health")

func get_exp_multiplier() -> float:
	return 1.0 + _combine_multipier("experience")

func get_pickup_increase() -> float:
	return _combine_multipier("pickup")

func get_crit_chance() -> float:
	return _combine_multipier("crit_chance")

func get_life_steal() -> float:
	return _combine_multipier("life_steal")

func get_dodge_chance() -> float:
	return _combine_multipier("dodge_chance")

func _combine_multipier(prop: String) -> float:
	var result = 0.0
	for skill in _multiplier:
		var x = _multiplier[skill].get(prop)
		if result == 0:
			result += x
		else:
			result *= 1.0 + x
	return result

func get_current_health() -> int:
	return stats.health.value


func heal(hp):
	stats.health.increase(hp)


func _on_PickupArea_area_entered(_area):
	pickup_sound.play()
	_area.pickup(self)


func _on_Health_zero_value():
	emit_signal("died")


func _on_hurt_box_damaged(dmg, _is_crit):
	if randf() <= get_dodge_chance():
		# TODO: show dodge/miss label
		return

	stats.damage_player(dmg * get_damage_multiplier())


func _on_player_stats_level_up(lvl):
	level_up_sound.play()
	SkillManager.show_next_skills()

func add_skill(node: Node):
	if node is Bow:
		hand.add_child(node)
	else:
		add_child(node)

func add_multiplier(skill: int, value: Multiplier):
	_multiplier[skill] = value
	multiplier_changed.emit()

	stats.exp_multiplier = get_exp_multiplier()
	
	if skill == SkillManager.Skill.STATS:
		pickup_magnet.set_range(get_pickup_increase())
		stats.health.multiply(get_health_multiplier())
		move.speed_multiplier = get_move_speed_multiplier()
