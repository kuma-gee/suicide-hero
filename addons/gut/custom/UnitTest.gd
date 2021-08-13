extends "res://addons/gut/test.gd"

class_name UnitTest


func press_key(input: String, strength = 0) -> InputEvent:
	return _create_input(input, strength, true)


func release_key(input: String) -> InputEvent:
	return _create_input(input, 0, false)


func _create_input(input: String, strength = 0, pressed = true) -> InputEvent:
	InputEventKey
	
	var ev = InputEventAction.new()
	ev.action = input
	ev.pressed = pressed
	ev.strength = strength
	return ev


func joypad_motion_event(axis: int, value: float) -> InputEvent:
	var joy = InputEventJoypadMotion.new()
	joy.axis = axis
	joy.axis_value = value
	return joy


func joypad_button_event(button: int, pressed = true) -> InputEvent:
	var joy = InputEventJoypadButton.new()
	joy.button_index = button
	joy.pressed = pressed
	return joy


func assert_array_eq(actual, expected: Array) -> void:
	if expected == null:
		assert_null(actual)
	else:
		if actual != null:
			assert_eq(actual.size(), expected.size())
			for x in expected:
				assert_has(actual, x)
		else:
			assert_not_null(actual)
