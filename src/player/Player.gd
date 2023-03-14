class_name Player extends CharacterBody2D

signal level_up(lvl)
signal died()

@export var res: PlayerResource
@export var stats: PlayerStats

@export var initial_skill: UpgradeResource

@onready var input := $PlayerInput
@onready var gun_point_root := $GunPointRoot
@onready var state_machine := $StateMachine

@onready var hand := $GunPointRoot/Hand
@onready var aim_direction := $AimDirection
@onready var move := $StateMachine/Move2D
@onready var knockback_state := $StateMachine/Knockback2D

@onready var sprite := $Body/Sprite
@onready var anim := $AnimationPlayer

@onready var pickup_magnet := $PickupMagnet
@onready var pickup_sound := $PickupArea/PickupSound
@onready var level_up_sound := $LevelUpSound

@onready var hp_bar: ValueFillBar = $HpBar
@onready var multiplier: Multiplier = $Multiplier

var _logger = Logger.new("Player")
var _multiplier := {}

func _ready():
	stats.health.max_value = res.health
	stats.health.value = res.health
	
	hp_bar.connect_value_fill(stats.health)
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

func get_stats() -> PlayerResource:
	return res

func get_attack_multiplier() -> float:
	return _combine_multipier(func(x): x.attack)

func _get_speed_multiplier() -> float:
	return _combine_multipier(func(x): x.move_speed)

func _get_damage_multiplier() -> float:
	return _combine_multipier(func(x): x.damage)

func _combine_multipier(map: Callable) -> float:
	var result = 0.0
	for skill in _multiplier:
		result += map.call(_multiplier[skill])
	return 1.0 + result


func get_current_health() -> int:
	return stats.health.value

func heal(hp):
	stats.health.increase(hp)


func _on_PickupArea_area_entered(_area):
	pickup_sound.play()
	_area.pickup(self)


func _on_Health_zero_value():
	emit_signal("died")


func _on_hurt_box_damaged(dmg):
	stats.damage_player(dmg * _get_damage_multiplier())


func _on_player_stats_level_up(lvl):
	level_up_sound.play()
	SkillManager.show_next_skills()

func add_skill(node: Node):
	if node is Bow:
		hand.add_child(node)
	else:
		add_child(node)

func add_multiplier(skill: SkillManager.Skill, value: Multiplier):
	multiplier[skill] = value

func apply(stat: StatUpgradeResource):
	res.health *= 1 + stat.health # player health is not saved in percentage
	res.attack += stat.attack
	res.speed += stat.speed
	res.pickup += stat.pickup
	
	pickup_magnet.set_range(res.pickup)
	stats.health.max_value = res.health
	move.speed_multiplier = _get_speed_multiplier()