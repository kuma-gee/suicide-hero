class_name InputType extends Node

enum Key {
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
	
	JOYSTICK_R2,
	JOYSTICK_L2,
	
	JOYSTICK_R_UP,
	JOYSTICK_R_DOWN,
	JOYSTICK_R_RIGHT,
	JOYSTICK_R_LEFT,
	
	JOYSTICK_START,
	JOYSTICK_R1,
	JOYSTICK_L1,
	JOYSTICK_A,
	JOYSTICK_B,
	JOYSTICK_X,
	JOYSTICK_Y,
	JOYSTICK_DPAD_UP,
	JOYSTICK_DPAD_DOWN,
	JOYSTICK_DPAD_LEFT,
	JOYSTICK_DPAD_RIGHT,
	JOYSTICK_SELECT,
}

const JOY_MOTION_MAP = {
	Key.JOYSTICK_L_RIGHT: [JOY_AXIS_0, 1],
	Key.JOYSTICK_L_LEFT: [JOY_AXIS_0, -1],
	Key.JOYSTICK_L_DOWN: [JOY_AXIS_1, 1],
	Key.JOYSTICK_L_UP: [JOY_AXIS_1, -1],
	Key.JOYSTICK_R_RIGHT: [JOY_AXIS_2, 1],
	Key.JOYSTICK_R_LEFT: [JOY_AXIS_2, -1],
	Key.JOYSTICK_R_DOWN: [JOY_AXIS_3, 1],
	Key.JOYSTICK_R_UP: [JOY_AXIS_3, -1],
	Key.JOYSTICK_L2: [JOY_AXIS_6, 1],
	Key.JOYSTICK_R2: [JOY_AXIS_7, 1],
}

const JOY_BUTTON_MAP = {
	JOY_L: Key.JOYSTICK_L1,
	JOY_L2: Key.JOYSTICK_L2,
	JOY_R: Key.JOYSTICK_R1,
	JOY_R2: Key.JOYSTICK_R2,
	JOY_XBOX_A: Key.JOYSTICK_A,
	JOY_XBOX_B: Key.JOYSTICK_B,
	JOY_XBOX_X: Key.JOYSTICK_X,
	JOY_XBOX_Y: Key.JOYSTICK_Y,
	JOY_DPAD_UP: Key.JOYSTICK_DPAD_UP,
	JOY_DPAD_DOWN: Key.JOYSTICK_DPAD_DOWN,
	JOY_DPAD_LEFT: Key.JOYSTICK_DPAD_LEFT,
	JOY_DPAD_RIGHT: Key.JOYSTICK_DPAD_RIGHT,
	JOY_START: Key.JOYSTICK_START,
	JOY_SELECT: Key.JOYSTICK_SELECT,
}

const MOUSE_BUTTON_MAP = {
	BUTTON_LEFT: Key.MOUSE_LEFT,
	BUTTON_RIGHT: Key.MOUSE_RIGHT,
	BUTTON_MIDDLE: Key.MOUSE_MIDDLE,
}

static func _is_key_event(type: int) -> bool:
	return type <= 0

static func to_text(type: int) -> String:
	var index = Key.values().find(type)
	if index != -1:
		return Key.keys()[index]
	
	var ev = to_event(type)
	if ev:
		return ev.as_text()
	return ""


static func to_event(type: int) -> InputEvent:
	if type <= 0:
		var key = InputEventKey.new()
		key.scancode = -type
		return key
		
	if type >= Key.JOYSTICK_L_UP and type <= Key.JOYSTICK_R_LEFT:
		var joypad = InputEventJoypadMotion.new()
		
		if type == Key.JOYSTICK_R2:
			joypad.axis = JOY_AXIS_7
			return joypad
			
		if type == Key.JOYSTICK_L2:
			joypad.axis = JOY_AXIS_6
			return joypad
		
		if type in [Key.JOYSTICK_L_LEFT, Key.JOYSTICK_L_RIGHT]:
			joypad.axis = JOY_AXIS_0
		elif type in [Key.JOYSTICK_L_UP, Key.JOYSTICK_L_DOWN]:
			joypad.axis = JOY_AXIS_1
		elif type in [Key.JOYSTICK_R_LEFT, Key.JOYSTICK_R_RIGHT]:
			joypad.axis = JOY_AXIS_2
		elif type in [Key.JOYSTICK_R_UP, Key.JOYSTICK_R_DOWN]:
			joypad.axis = JOY_AXIS_3
		
		var positive_value = [
			Key.JOYSTICK_L_RIGHT,
			Key.JOYSTICK_L_DOWN,
			Key.JOYSTICK_R_RIGHT,
			Key.JOYSTICK_R_DOWN,
		]
		joypad.axis_value = 1 if type in positive_value else -1
		return joypad
	
	if type >= Key.MOUSE_LEFT and type <= Key.MOUSE_MIDDLE:
		var idx = MOUSE_BUTTON_MAP.values().find(type)
		if idx != -1:
			var mouse = InputEventMouseButton.new()
			mouse.button_index = MOUSE_BUTTON_MAP.keys()[idx]
			return mouse
	
	if type >= Key.JOYSTICK_START and type <= Key.JOYSTICK_SELECT:
		var idx = JOY_BUTTON_MAP.values().find(type)
		if idx != -1:
			var joy_button = InputEventJoypadButton.new()
			joy_button.button_index = JOY_BUTTON_MAP.keys()[idx]
			return joy_button
	
	return null
	
static func to_type(event: InputEvent) -> int:
	if event is InputEventKey:
		return -event.scancode
	
	if event is InputEventJoypadMotion and event.axis_value != 0:
		# TODO: use JOY_MOTION_MAP
		if _is_left_stick(event):
			if _is_horizontal_axis(event):
				return Key.JOYSTICK_L_LEFT if event.axis_value < 0 else Key.JOYSTICK_L_RIGHT
			elif _is_vertical_axis(event):
				return Key.JOYSTICK_L_UP if event.axis_value < 0 else Key.JOYSTICK_L_DOWN
		if _is_right_stick(event):
			if _is_horizontal_axis(event):
				return Key.JOYSTICK_R_LEFT if event.axis_value < 0 else Key.JOYSTICK_R_RIGHT
			elif _is_vertical_axis(event):
				return Key.JOYSTICK_R_UP if event.axis_value < 0 else Key.JOYSTICK_R_DOWN
	elif event is InputEventJoypadButton and JOY_BUTTON_MAP.has(event.button_index):
		return JOY_BUTTON_MAP.get(event.button_index)
	elif event is InputEventMouseButton and MOUSE_BUTTON_MAP.has(event.button_index):
		return MOUSE_BUTTON_MAP.get(event.button_index)
	
	return 1

static func _is_left_stick(event: InputEventJoypadMotion) -> bool:
	return event.axis in [JOY_AXIS_0, JOY_AXIS_1]
	
static func _is_right_stick(event: InputEventJoypadMotion) -> bool:
	return event.axis in [JOY_AXIS_2, JOY_AXIS_3]

static func _is_horizontal_axis(event: InputEventJoypadMotion) -> bool:
	return event.axis in [JOY_AXIS_0, JOY_AXIS_2]
	
static func _is_vertical_axis(event: InputEventJoypadMotion) -> bool:
	return event.axis in [JOY_AXIS_1, JOY_AXIS_3]
