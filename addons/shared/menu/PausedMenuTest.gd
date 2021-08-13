extends UnitTest

var menu: PausedMenu

func before_each():
	menu = autofree(PausedMenu.new())


func test_paused():
	add_child(menu)
	assert_true(get_tree().paused)
	
	assert_eq(menu.pause_mode, PAUSE_MODE_PROCESS)
	
	remove_child(menu)
	assert_false(get_tree().paused)
