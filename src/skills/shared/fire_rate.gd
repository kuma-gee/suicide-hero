class_name FireRateTimer
extends Timer

var _logger = Logger.new("FireRateTimer")
var player: Player

var _original_time: float

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	player.attack_speed_changed.connect(func(): update_firerate(wait_time))
	one_shot = false
	autostart = false

func update_firerate(time: float):
	if not _original_time:
		_original_time = time

	# TODO: check if updated correcty and not called multiple times
	var new_time = _original_time * player.get_attack_speed_multiplier()
	if is_stopped() or new_time != wait_time:
		start(new_time)

