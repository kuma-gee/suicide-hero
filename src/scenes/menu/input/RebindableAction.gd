class_name RebindableAction extends Button

signal rebind(action)

export var action: String setget _set_action
export var joypad_exclusive := false

onready var timer := $Timer
onready var sprite := $InputSprite

const start_type_key = InputType.Key.MOUSE_LEFT

var _editing = false
var profile: InputProfile


func _set_action(a: String) -> void:
	action = a.to_lower()
	update_current_input()


func update_current_input() -> void:
	disabled = joypad_exclusive and not profile.joypad
	if profile:
		var ev = profile.get_input(action)
		sprite.key = InputType.to_type(ev)

func _on_Button_pressed() -> void:
	disabled = true
	timer.start()

func _on_Timer_timeout():
	emit_signal("rebind", action)


func _on_InputSprite_input_text(text):
	icon = null
	self.text = text


func _on_InputSprite_input_texture(tex):
	text = ""
	icon = load(tex)
