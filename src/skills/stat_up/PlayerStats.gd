class_name PlayerStats extends Node

signal level_up(lvl)

@export var level := 1
@export var gain_experience := true

@export var pickup_magnet: PickupMagnet
@export var move_state: Move2D

@onready var experience := $Experience
@onready var health := $Health

@export var upgrades: Array[StatUpgradeResource]
@export var player: Player = owner

var _original_health: int
var _original_speed: float

func _ready():
	health.max_value = player.res.health
	
	_original_health = player.res.health
	_original_speed = move_state.speed

func _process(delta):
	_gain_experience()

func _gain_experience() -> void:
	var ex = health.value * 0.005
	experience.increase(ex)
	health.reduce(ex)

func _on_Experience_overflow():
	level += 1
	_update_max_experience()
	emit_signal("level_up", level)

func _update_max_experience() -> void:
	experience.max_value *= 1.1

func heal_player(hp: int) -> void:
	health.increase(hp)


func apply(res: UpgradeResource):
	var stat = res as StatUpgradeResource
	if stat:
		player.res.health *= 1 + stat.health # player health is not saved in percentage
		player.res.attack += stat.attack
		player.res.speed += stat.speed
		player.res.pickup += stat.pickup
		
		pickup_magnet.set_range(player.res.pickup)
		health.max_value = player.res.health
		move_state.speed = _original_speed * (1 + player.res.speed)

func get_upgrade():
	if upgrades.is_empty(): return null
	return upgrades.pick_random()
