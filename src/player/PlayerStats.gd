class_name PlayerStats extends Node

signal level_up(lvl)

@export var level := 1
@export var gain_experience := true

@onready var experience := $Experience
@onready var health := $Health

func _process(delta):
	_gain_experience()

func _gain_experience() -> void:
	var ex = health.value * 0.01
	experience.increase(ex)
	health.reduce(ex)

func _on_Experience_overflow():
	level += 1
	_update_max_experience()
	emit_signal("level_up", level)

func _update_max_experience() -> void:
	experience.max_value *= 1.25

func heal_player(hp: int) -> void:
	health.increase(hp)

func damage_player(dmg: int) -> void:
	health.reduce(dmg)
