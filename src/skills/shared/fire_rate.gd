class_name FireRateTimer
extends Timer

var _logger = Logger.new("FireRateTimer")
var player: Player

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	player.attack_speed_changed.connect(func(): update_firerate(wait_time))
	one_shot = false
	autostart = false

func update_firerate(time: float):
	# TODO: check if updated correcty and not called multiple times
	start(time * player.get_attack_speed_multiplier())

