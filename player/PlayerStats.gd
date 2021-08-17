class_name PlayerStats extends Node

signal level_up(lvl)

export var level = 1

onready var experience := $Experience
onready var health := $Health

var exp_gain_eq = ExponentialEquation.new(2, 10, 5)
var exp_lvl_eq = LogarithmEquation.new(100, 50)


func _on_ExperienceTimer_timeout():
	_gain_experience()


func _gain_experience() -> void:
	var ex = _get_experience(health.get_percentage())
	experience.increase(ex)
	health.reduce(ex)


func _get_experience(hp_percentage: float) -> float:
	if hp_percentage == 0:
		return 0.0
	
	var x = 1 / hp_percentage
	return exp_gain_eq.y(-x)


func _on_Experience_overflow():
	level += 1
	_update_max_experience()
	emit_signal("level_up", level)

func _update_max_experience() -> void:
	experience.max_value = _get_experience_for_next_level()

func _get_experience_for_next_level() -> int:
	return exp_lvl_eq.y(level)

func heal_player(hp: int) -> void:
	health.increase(hp)
