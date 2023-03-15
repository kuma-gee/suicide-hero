class_name PlayerStats extends Node

signal level_up(lvl)

@export var level := 1
@export var exp_conversion := 0.001
@export var exp_increase := 0.25

@onready var experience := $Experience
@onready var health := $Health

func _process(delta):
	_gain_experience()

func _gain_experience() -> void:
	var ex = health.value * exp_conversion
	experience.increase(ex)
	health.reduce(ex)

func _on_Experience_overflow():
	level += 1
	_update_max_experience()
	emit_signal("level_up", level)

func _update_max_experience() -> void:
	experience.max_value *= 1 + exp_increase

func heal_player(hp: int) -> void:
	health.increase(hp)

func damage_player(dmg: int) -> void:
	health.reduce(dmg)
