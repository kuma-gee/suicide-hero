extends GUIMenu

class_name PausedMenu

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	_pause()

func _exit_tree():
	_resume()
	
func _pause():
	get_tree().paused = true

func _resume():
	get_tree().paused = false
