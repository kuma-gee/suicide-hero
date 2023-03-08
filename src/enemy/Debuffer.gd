class_name Debuffer
extends Area2D

signal debuff_changed()

var movement := 0.0 : set = _set_movement

func _set_movement(val):
    movement = val
    debuff_changed.emit()