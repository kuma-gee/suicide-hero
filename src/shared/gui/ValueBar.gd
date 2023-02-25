extends Control

@export var max_value := 100.0 : set = _set_max_value
@export var color: Color

@onready var bar := $ProgressBar
@onready var value_effect := $ValueEffect
@onready var max_value_effect := $MaxValueEffect

@onready var _max_width := size.x
@onready var value := max_value : set = _set_value

var _border_width := 0.0

func _ready():
	var fg: StyleBoxFlat = bar.get("theme_override_styles/background").duplicate()
	fg.set("bg_color", color)
	bar.set("theme_override_styles/foreground", fg)


func connect_value_fill(v: ValueFill) -> void:
	var _x = v.connect("max_value_changed", _set_max_value)
	var _y = v.connect("value_changed", _set_value)


func _set_value(v) -> void:
	value_effect.value = v


func _set_max_value(v) -> void:
	max_value_effect.value = v

