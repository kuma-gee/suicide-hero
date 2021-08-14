extends Control

export var max_value := 100.0 setget _set_max_value
export var color: Color

onready var bar := $PanelContainer/Bar
onready var panel := $PanelContainer

onready var _max_width := rect_size.x
onready var value := max_value setget _set_value

var _border_width := 0.0

func _ready():
	bar.color = color
	var p = panel.get("custom_styles/panel") as StyleBoxFlat
	_max_width -= p.border_width_left + p.border_width_right


func connect_value_fill(value: ValueFill) -> void:
	value.connect("max_value_changed", self, "_set_max_value")
	value.connect("value_changed", self, "_set_value")


func _process(delta):
	_update_bar()


func _update_bar():
	var percentage = value / max_value
	var width = percentage * _max_width
	
	bar.rect_size.x = width


func _set_value(v) -> void:
	value = v
	_update_bar()


func _set_max_value(v) -> void:
	max_value = v
	_update_bar()

