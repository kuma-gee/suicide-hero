extends Popup

#@export var remapping_inputs_path: NodePath
@export var remapping_inputs: RemappingInputs

var remapping_action: String : set = _set_remapping_action

func _ready():
	hide()
	remapping_inputs.remapping.connect(_set_remapping_action)
	
func _set_remapping_action(action: String) -> void:
	remapping_action = action
	if action != "":
		show()
	else:
		hide()

func _should_handle_event(event: InputEvent) -> bool:
	return remapping_action != "" and \
		not event is InputEventMouseMotion and \
		remapping_inputs.profile.is_valid(event, true)

func _input(event: InputEvent) -> void:
	if _should_handle_event(event):
		remapping_inputs.profile.change_input(remapping_action, event)
		get_viewport().set_input_as_handled()
		self.remapping_action = ""
		
