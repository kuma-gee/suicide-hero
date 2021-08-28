class_name RemappingInputs extends Control

signal remapping(action)

var profile: InputProfile

func _ready():
	var last = null
	for child in get_children():
		if child is RebindableAction:
			var label = Label.new()
			label.text = child.action.to_upper()
			if last != null:
				add_child_below_node(last, label)
			else:
				add_child(label)
				move_child(label, 0)
			child.connect("rebind", self, "_on_rebind")
			last = child
	
	_update_profile()
	var _x = InputManager.connect("device_changed", self, "_update_profile")

func _on_rebind(action: String) -> void:
	emit_signal("remapping", action)

func _update_profile() -> void:
	if profile:
		profile.disconnect("input_changed", self, "_on_input_change")
	profile = InputManager.get_profile()
	var _x = profile.connect("input_changed", self, "_on_input_change")
	update()

func _on_input_change(_action: String) -> void:
	update() # TODO: only update the changed action

func update() -> void:
	for child in get_children():
		if child is RebindableAction:
			child.profile = profile
			child.update_current_input()
