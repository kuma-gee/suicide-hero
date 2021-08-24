class_name InputType extends Node

enum {
	ARROW_UP = 2,
	ARROW_DOWN,
	ARROW_LEFT,
	ARROW_RIGHT,
	
	MOUSE_LEFT,
	MOUSE_RIGHT,
	MOUSE_MIDDLE,
	
	JOYSTICK_L_UP,
	JOYSTICK_L_DOWN,
	JOYSTICK_L_RIGHT,
	JOYSTICK_L_LEFT,
	
	JOYSTICK_R_UP,
	JOYSTICK_R_DOWN,
	JOYSTICK_R_RIGHT,
	JOYSTICK_R_LEFT,
}

static func to_event(type: int) -> InputEvent:
	if type <= 0:
		var key = InputEventKey.new()
		key.scancode = -type
		return key
		
	if type >= JOYSTICK_L_UP and type <= JOYSTICK_R_LEFT:
		var joypad = InputEventJoypadMotion.new()
		if type in [JOYSTICK_L_LEFT, JOYSTICK_L_RIGHT]:
			joypad.axis = JOY_AXIS_0
		elif type in [JOYSTICK_L_UP, JOYSTICK_L_DOWN]:
			joypad.axis = JOY_AXIS_1
		elif type in [JOYSTICK_R_LEFT, JOYSTICK_R_RIGHT]:
			joypad.axis = JOY_AXIS_2
		elif type in [JOYSTICK_R_UP, JOYSTICK_R_DOWN]:
			joypad.axis = JOY_AXIS_3
		
		var positive_value = [
			JOYSTICK_L_RIGHT,
			JOYSTICK_L_DOWN,
			JOYSTICK_R_RIGHT,
			JOYSTICK_R_DOWN,
		]
		joypad.axis_value = 1 if type in positive_value else -1
		return joypad
	
	if type >= MOUSE_LEFT and type <= MOUSE_MIDDLE:
		var mouse = InputEventMouseButton.new()
		if type == MOUSE_LEFT:
			mouse.button_index = BUTTON_LEFT
		elif type == MOUSE_RIGHT:
			mouse.button_index = BUTTON_RIGHT
		elif type == MOUSE_MIDDLE:
			mouse.button_index = BUTTON_MIDDLE
		return mouse
	
	return null

static func to_type(event: InputEvent) -> int:
	if event is InputEventKey:
		return -event.scancode
	
	if event is InputEventJoypadMotion and event.axis_value != 0:
		if _is_left_stick(event):
			if _is_horizontal_axis(event):
				return JOYSTICK_L_LEFT if event.axis_value < 0 else JOYSTICK_L_RIGHT
			elif _is_vertical_axis(event):
				return JOYSTICK_L_UP if event.axis_value < 0 else JOYSTICK_L_DOWN
		if _is_right_stick(event):
			if _is_horizontal_axis(event):
				return JOYSTICK_R_LEFT if event.axis_value < 0 else JOYSTICK_R_RIGHT
			elif _is_vertical_axis(event):
				return JOYSTICK_R_UP if event.axis_value < 0 else JOYSTICK_R_DOWN
	elif event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT:
				return MOUSE_LEFT
			elif event.button_index == BUTTON_RIGHT:
				return MOUSE_RIGHT
			elif event.button_index == BUTTON_MIDDLE:
				return MOUSE_MIDDLE

	return 1

static func _is_left_stick(event: InputEventJoypadMotion) -> bool:
	return event.axis in [JOY_AXIS_0, JOY_AXIS_1]
	
static func _is_right_stick(event: InputEventJoypadMotion) -> bool:
	return event.axis in [JOY_AXIS_2, JOY_AXIS_3]

static func _is_horizontal_axis(event: InputEventJoypadMotion) -> bool:
	return event.axis in [JOY_AXIS_0, JOY_AXIS_2]
	
static func _is_vertical_axis(event: InputEventJoypadMotion) -> bool:
	return event.axis in [JOY_AXIS_1, JOY_AXIS_3]
