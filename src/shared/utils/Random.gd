extends Node

class_name Random

static func random_int(min_value: int, max_value: int) -> int:
	return (randi() % max_value) + min_value


static func random_double(min_value: float = 0, max_value: float = 1) -> float:
	return rand_range(min_value, max_value)
