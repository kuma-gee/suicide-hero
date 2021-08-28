extends Control

export var max_value := 100.0 setget _set_max_value
export var color: Color

onready var bar := $ProgressBar
onready var value_effect := $ValueEffect
onready var max_value_effect := $MaxValueEffect

onready var _max_width := rect_size.x
onready var value := max_value setget _set_value

var _border_width := 0.0

func _ready():
	var fg: StyleBoxFlat = bar.get("custom_styles/bg").duplicate()
	fg.set("bg_color", color)
	bar.set("custom_styles/fg", fg)


func connect_value_fill(v: ValueFill) -> void:
	var _x = v.connect("max_value_changed", self, "_set_max_value")
	var _y = v.connect("value_changed", self, "_set_value")


func _set_value(v) -> void:
	value_effect.value = v


func _set_max_value(v) -> void:
	max_value_effect.value = v

