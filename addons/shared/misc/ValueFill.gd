extends Node

signal zero_value
signal value_changed(value)
signal max_value_changed(value)

class_name ValueFill

export var max_value = 10 setget set_max_value
onready var value = max_value setget _set_value

func _ready():
	# use deferred so the values are initialized before emitting
	call_deferred("emit_signal", "max_value_changed", max_value)
	call_deferred("emit_signal", "value_changed", value)

func reduce(value: int) -> void:
	self.value -= value


func increase(value: int) -> void:
	self.value += value


func is_full_value() -> bool:
	return value == max_value


func fill() -> void:
	self.value = max_value


func _set_value(hp: int) -> void:
	value = clamp(hp, 0, max_value)
	emit_signal("value_changed", value)

	if value <= 0:
		value = 0
		emit_signal("zero_value")

func set_max_value(hp: int) -> void:
	max_value = clamp(hp, 1, hp)
	emit_signal("max_value_changed", max_value)
