class_name FaceMouse extends Node2D

func _process(delta):
	look_at(get_global_mouse_position())
