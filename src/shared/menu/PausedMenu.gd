extends Control

class_name PausedMenu

func _ready():
	pause_mode = Node.PAUSE_MODE_PROCESS
	_pause()
	
func _exit_tree():
	_resume()
	
func _pause():
	get_tree().paused = true

func _resume():
	get_tree().paused = false
