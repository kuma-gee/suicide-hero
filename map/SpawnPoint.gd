class_name SpawnPoint extends Position2D

var enabled = true


func _on_VisibilityNotifier2D_screen_exited():
	enabled = true


func _on_VisibilityNotifier2D_screen_entered():
	enabled = false
