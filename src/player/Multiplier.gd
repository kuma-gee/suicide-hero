class_name Multiplier
extends Object

var health := 0.0
var pickup := 0.0
var attack := 0.0
var attack_speed := 0.0
var move_speed := 0.0
var damage:= 0.0

func get_attack() -> float:
	return 1.0 + _combine_multipier(res.attack, func(x): x.attack)

# Firerate has to be reduced
func get_attack_speed() -> float:
	return 1.0 - _combine_multipier(res.attack_speed, func(x): x.attack_speed)

func get_move_speed() -> float:
	return 1.0 + _combine_multipier(res.speed, func(x): x.move_speed)

func get_pickup() -> float:
	return 1.0 + _combine_multipier(res.speed, func(x): x.move_speed)

func get_damage() -> float:
	return 1.0 + _combine_multipier(func(x): x.damage)

func _combine_multipier(base: float, map: Callable) -> float:
	var result = base
	for skill in _multiplier:
		result *=  1 + map.call(_multiplier[skill])
	return result