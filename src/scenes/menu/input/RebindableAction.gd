class_name RebindableAction extends Button

signal rebind(action)

export var action: String setget _set_action
export var joypad_exclusive := false

onready var timer := $Timer

var _editing = false
var profile: InputProfile


func _set_action(a: String) -> void:
	action = a.to_lower()
	update_current_input()


func update_current_input() -> void:
	disabled = joypad_exclusive and not profile.joypad
	if profile:
		_update_button_text(profile.get_input(action))


func _update_button_text(input_event: InputEvent) -> void:
	text = InputType.to_text(InputType.to_type(input_event))


func _on_Button_pressed() -> void:
	disabled = true
	timer.start()

func _on_Timer_timeout():
	emit_signal("rebind", action)
