extends Node

signal device_changed()

export var main_device := 0
export var joypad := false setget _set_joypad

func _unhandled_input(event):
	if not InputType.is_empty(event):
		self.joypad = InputType.is_joypad(event)


func _set_joypad(value: bool) -> void:
	if joypad == value: return
	
	joypad = value
	emit_signal("device_changed")


func get_profile(device = main_device) -> InputProfile:
	for profile in get_children():
		if profile.device == device and profile.joypad == joypad:
			return profile
		
	print("Returned null profile")
	return null

func get_profiles() -> Array:
	return get_children()
