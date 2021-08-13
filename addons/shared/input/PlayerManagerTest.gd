extends UnitTest

var manager: PlayerManager

func before_each():
	manager = autofree(PlayerManager.new())
	watch_signals(manager)

func test_add_players():
	manager.add_player(press_key("ui_accept"))
	assert_signal_emitted_with_parameters(manager, "player_added", [{"device": 0, "joypad": false}, 1])
	assert_eq(manager.get_child_count(), 1)
	
	manager.add_player(press_key("ui_accept"))
	assert_signal_emit_count(manager, "player_added", 1)
	
	manager.add_player(joypad_button_event(JOY_SONY_X))
	assert_signal_emitted_with_parameters(manager, "player_added", [{"device": 0, "joypad": true}, 2])
	assert_eq(manager.get_child_count(), 2)
	
	manager.add_player(joypad_button_event(JOY_SONY_X))
	assert_signal_emit_count(manager, "player_added", 2)

func test_add_max_players():
	manager.max_players = 1
	manager.add_player(press_key("ui_accept"))
	assert_signal_emit_count(manager, "player_added", 1)
	
	manager.add_player(joypad_button_event(JOY_SONY_X))
	assert_signal_emit_count(manager, "player_added", 1)

func test_reset_player():
	manager.add_player(press_key("ui_accept"))
	assert_eq(manager.players.size(), 1)
	assert_eq(manager.get_child_count(), 1)
	
	# Children need to be auto freed because they are removed as child
	for c in manager.get_children():
		autofree(c)
	
	manager.reset_players()
	assert_eq(manager.players.size(), 0)
	assert_eq(manager.get_child_count(), 0)
