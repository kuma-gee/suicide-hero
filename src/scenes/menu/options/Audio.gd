extends MenuBase

func _exit_tree():
	Settings.save_audio_settings()
