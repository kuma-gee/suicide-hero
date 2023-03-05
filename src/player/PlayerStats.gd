class_name PlayerStats extends Node

signal player_stat_changed(res: PlayerStats)
signal level_up(lvl)

@export var level := 1
@export var gain_experience := true

@export var pickup_magnet: PickupMagnet
@export var move_state: Move2D

@onready var experience := $Experience
@onready var health := $Health

@export var upgrades: Array[StatUpgradeResource]
@export var player_res: PlayerResource

var _original_health: int
var _original_speed: float
var _original_range: float

func _ready():
	health.max_value = player_res.health
	
	_original_health = player_res.health
	_original_speed = move_state.speed
	_original_range = pickup_magnet.get_range()
	player_stat_changed.emit(player_res)

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
		player_res.health *= 1 + stat.health # player health is not saved in percentage
		player_res.attack += stat.attack
		player_res.speed += stat.speed
		player_res.pickup += stat.pickup
		
		pickup_magnet.set_range(_original_range * player_res.pickup)
		health.max_value = player_res.health
		move_state.speed = _original_speed * player_res.speed
		player_stat_changed.emit(player_res)

func get_upgrade():
	return upgrades.pick_random()
