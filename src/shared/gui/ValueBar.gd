class_name ValueFillBar
extends ProgressBar

func connect_value_fill(v: ValueFill) -> void:
	var _x = v.connect("max_value_changed", _set_max_value)
	var _y = v.connect("value_changed", _set_value)

func _set_value(v) -> void:
	value = v

func _set_max_value(v) -> void:
	max_value = v

