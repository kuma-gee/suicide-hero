extends Node

class_name PlayerManager

signal player_added(player, player_num)

export var max_players = 4

var players = []

func _is_join_event(event: InputEvent) -> bool:
	return event.is_action_pressed("ui_accept")


func _is_max_players() -> bool:
	return players.size() >= max_players


func add_player(event: InputEvent) -> void:
	if not _is_join_event(event) or _is_max_players(): return
	
	var data = {
		"device": event.device,
		"joypad": PlayerInput.is_joypad_event(event),
	}
	
	if player_exists(data):
		print("Player already exists")
		return
	
	players.append(data)
	_create_input(data)
	emit_signal("player_added", data, players.size())
	print("Player added: " + str(data))


func _create_input(player) -> void:
	var input = PlayerInput.new(player["device"], player["joypad"])
	add_child(input)


func player_exists(player_data: Dictionary) -> bool:
	return find_player_index(player_data) != -1


func find_player_index(player: Dictionary) -> int:
	for i in range(0, players.size()):
		var input = players[i]
		if input["device"] == player["device"] and \
			input["joypad"] == player["joypad"]:
			return i
	return -1


func find_input(player: Dictionary) -> PlayerInput:
	var index = find_player_index(player)
	if index != -1:
		return get_child(index) as PlayerInput
	return null


func get_inputs() -> Array:
	var result = []
	for child in get_children():
		if child is PlayerInput:
			result.append(child)
	return result

func get_input(idx: int) -> PlayerInput:
	var inputs = get_inputs()
	return inputs[idx] if idx >= 0 and idx < inputs.size() else null

func get_player_count() -> int:
	return players.size()

func reset_players() -> void:
	players.clear()
	for child in get_children():
		remove_child(child)
