class_name ValueFillBar
extends Range

@export var value_fill: ValueFill

func _ready():
	if value_fill:
		connect_value_fill(value_fill)

func connect_value_fill(v: ValueFill) -> void:
	v.max_value_changed.connect(_set_max_value)
	v.value_changed.connect(_set_value)

func _set_value(v) -> void:
	value = v
	changed.emit()

func _set_max_value(v) -> void:
	max_value = v
	changed.emit()

