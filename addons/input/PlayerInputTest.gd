extends UnitTest

var player_input: PlayerInput


func before_each():
	player_input = autofree(PlayerInput.new())


func test_ignore_joypad_if_disabled():
	player_input.type = PlayerInput.Type.KEYBOARD

	player_input.handle_input(press_key("move_left", 1))
	assert_true(player_input.is_pressed("move_left"))

	player_input.handle_input(joypad_motion_event(JOY_AXIS_0, 1))
	assert_false(player_input.is_pressed("move_right"))


func test_only_read_joypad_if_enabled():
	player_input.type = PlayerInput.Type.JOYPAD

	player_input.handle_input(press_key("move_left", 1))
	assert_false(player_input.is_pressed("move_left"))

	player_input.handle_input(joypad_motion_event(JOY_AXIS_0, 1))
	assert_true(player_input.is_pressed("move_right"))


func test_read_same_device():
	player_input.type = PlayerInput.Type.SAME_DEVICE
	
	player_input.handle_input(press_key("move_left", 1))
	assert_true(player_input.is_pressed("move_left"))

	player_input.handle_input(joypad_motion_event(JOY_AXIS_0, 1))
	assert_true(player_input.is_pressed("move_right"))


func test_device_id():
	var input = autofree(PlayerInput.new(100))

	var ev = press_key("move_left")

	input.handle_input(ev)
	assert_false(input.is_pressed("move_left"))

	ev.device = 100
	input.handle_input(ev)
	assert_true(input.is_pressed("move_left"))
