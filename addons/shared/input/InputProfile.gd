class_name InputProfile

var mappings = {}
var player_input: PlayerInput
var mappable = []

func _init(i: PlayerInput, actions: Array):
	player_input = i
	mappable = actions


func get_current_input(action: String) -> InputEvent:
	var inputs = InputMap.get_action_list(action)
	for i in inputs:
		if player_input.joypad and PlayerInput.is_joypad_event(i):
			return i
		if not player_input.joypad and not PlayerInput.is_joypad_event(i):
			return i
	return null


func change_input(action: String, ev: InputEvent) -> void:
	InputMap.action_erase_event(action, get_current_input(action))
	InputMap.action_add_event(action, ev)
	
#	for action in InputMap.get_action_list(action):
#		pass
