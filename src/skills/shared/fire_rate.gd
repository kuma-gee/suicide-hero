class_name FireRateTimer
extends Timer

# var _can_fire = true

var _logger = Logger.new("FireRateTimer")

func _ready():
	one_shot = false
	autostart = false
	# timeout.connect(_on_timer_timeout)

func update_firerate(time: float):
	wait_time = time
	start()
	
# func can_fire(firerate) -> bool:
# 	if not _can_fire: return false
# 	_can_fire = false
	
# 	start(firerate)
# 	return true

# func _on_timer_timeout():
# 	_can_fire = true
