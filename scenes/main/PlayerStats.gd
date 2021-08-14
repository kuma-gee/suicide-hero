class_name PlayerStats extends Node

signal level_up(lvl)

export var level = 1

onready var experience := $Experience
onready var health := $Health


func _on_ExperienceTimer_timeout():
	_gain_experience()
	
	print(experience.value)


func _gain_experience() -> void:
	var ex = _get_experience(health.get_percentage())
	health.reduce(ex)
	experience.increase(ex)


func _get_experience(hp_percentage: float) -> float:
	if hp_percentage == 0:
		return 0.0
	
	var x = 1 / hp_percentage
	return (10 * pow(2, -x)) + 5


func _on_Experience_overflow():
	level += 1
	emit_signal("level_up", level)
