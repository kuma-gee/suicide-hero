class_name TransitionEffect extends Effect

enum Type {
	GLOBAL,
	LOCAL,
}

export var property := "value"

var value = null setget _set_value

func _set_value(v):
	value = v
	start()

func apply_tween(tween: Tween):
	var start = node.get(property)
	var end = value
	.interpolate_property(tween, property, start, end)
