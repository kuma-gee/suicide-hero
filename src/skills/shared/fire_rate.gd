class_name FireRateTimer
extends Timer

var _logger = Logger.new("FireRateTimer")
var player: Player

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	player.multiplier_changed.connect(func(): update_firerate(wait_time / player.get_attack_speed_multiplier()))
	one_shot = false
	autostart = false

func update_firerate(time: float):
	# TODO: check if updated correcty and not called multiple times
	var new_time = time * player.get_attack_speed_multiplier()
	_logger.debug("upgrade firerate from %s to %s" % [wait_time, new_time])
	if is_stopped() or new_time != wait_time:
		start(new_time)
		_logger.debug("starting with new time: %s" % new_time)

