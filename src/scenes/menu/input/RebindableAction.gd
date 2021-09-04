class_name RebindableAction extends Control

signal rebind(action)

export var action: String setget _set_action
export var joypad_exclusive := false

onready var timer := $Timer
onready var sprite := $InputSprite
onready var text_button := $TextButton
onready var texture_button := $TexButton

const start_type_key = InputType.Key.MOUSE_LEFT

var _editing = false
var profile: InputProfile


func _set_action(a: String) -> void:
	action = a.to_lower()
	update_current_input()


func update_current_input() -> void:
	$TextButton.disabled = joypad_exclusive and not profile.joypad
	$TexButton.set_disabled(joypad_exclusive and not profile.joypad)
	if profile:
		var ev = profile.get_input(action)
		sprite.key = InputType.to_type(ev)


func _on_TextButton_pressed() -> void:
	text_button.disabled = true
	timer.start()


func _on_TexButton_pressed():
	texture_button.set_disabled(true)
	timer.start()

func _on_Timer_timeout():
	emit_signal("rebind", action)


func _on_InputSprite_input_text(text):
	texture_button.hide()
	if text == "":
		text = "-"
	text_button.text = text
	text_button.show()


func _on_InputSprite_input_texture(tex):
	text_button.hide()
	texture_button.texture_normal = load(tex)
	texture_button.show()


func grab_focus():
	_get_active_button().grab_focus()


func _get_active_button():
	if text_button.visible:
		return text_button
	return texture_button
