class_name ValueFillBar
extends Range

func connect_value_fill(v: ValueFill) -> void:
	v.max_value_changed.connect(_set_max_value)
	v.value_changed.connect(_set_value)

func _set_value(v) -> void:
	value = v
	changed.emit()

func _set_max_value(v) -> void:
	max_value = v
	changed.emit()

