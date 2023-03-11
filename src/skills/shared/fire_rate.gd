class_name FireRateTimer
extends Timer

var _logger = Logger.new("FireRateTimer")

func _ready():
	one_shot = false
	autostart = false

func update_firerate(time: float):
	start(time)

