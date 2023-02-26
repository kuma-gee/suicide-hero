class_name ValueFill extends Node

signal overflow()
signal zero_value()
signal full_value()
signal value_changed(value)
signal max_value_changed(value)

@export var start_empty = false
@export var allow_overflow = false

@export var max_value := 100.0 : set = set_max_value

var value := 0.0 : set = _set_value

func _ready():
	if not start_empty:
		value = max_value
	
	# use deferred so the values are initialized before emitting
	call_deferred("emit_signal", "max_value_changed", max_value)
	call_deferred("emit_signal", "value_changed", value)

func reduce(v: float) -> void:
	self.value -= v


func increase(v: float) -> void:
	self.value += v


func is_full_value() -> bool:
	return value == max_value


func fill() -> void:
	self.value = max_value


func _set_value(hp: float) -> void:
	if value == hp: return
	
	value = float(clamp(hp, 0, max_value))

	if value <= 0:
		value = 0
		emit_signal("zero_value")
	elif value >= max_value:
		emit_signal("full_value")
		
		if allow_overflow and hp >= max_value:
			value = 0
			emit_signal("overflow")
			var diff = hp - max_value
			if diff != 0:
				increase(diff)
				return
		
	emit_signal("value_changed", value)

func set_max_value(hp: float) -> void:
	max_value = float(clamp(hp, 1, hp))
	emit_signal("max_value_changed", max_value)

func get_percentage() -> float:
	return value / float(max_value)
