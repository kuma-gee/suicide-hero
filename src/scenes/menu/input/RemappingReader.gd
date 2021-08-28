extends Popup

export var remapping_inputs_path: NodePath
onready var remapping_inputs: RemappingInputs = get_node(remapping_inputs_path)

var remapping_action: String setget _set_remapping_action

func _ready():
	var _x = remapping_inputs.connect("remapping", self, "_set_remapping_action")
	
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
		get_tree().set_input_as_handled()
		self.remapping_action = ""
		
