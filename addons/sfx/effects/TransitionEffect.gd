class_name TransitionEffect extends Effect

enum Type {
	GLOBAL,
	LOCAL,
}

@export var property := "value"

var value = null : set = _set_value

func _set_value(v):
	value = v
	start_effect()

func apply_tween(tween: Tween):
	var start = node.get(property)
	var end = value
	super.interpolate_property(tween, property, start, end)
