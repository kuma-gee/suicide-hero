class_name Debuffer
extends Area2D

signal debuff_changed()

var movement := {} : get = _get_movement

func _get_movement():
    var sum = 0
    for x in movement.values():
        sum += x
    return 1 - sum

func set_movement(key, val):
    movement[key] = val
    debuff_changed.emit()