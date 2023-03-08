class_name Debuffer
extends Area2D

signal debuff_changed()

var _movement := {}
var _logger = Logger.new("Debuffer")

func get_movement_multiplier():
	var sum = 0
	for x in _movement.values():
		sum += x
	return 1 - sum

func set_movement(key, val):
	_movement[key] = val
	debuff_changed.emit()
	_logger.trace("Updating movement debuff of %s: %s" % [key, val])
