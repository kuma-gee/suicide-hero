extends Label

var time_in_sec := 0

func _ready():
	var timer = Timer.new()
	timer.autostart = true
	timer.one_shot = false
	timer.wait_time = 1
	timer.timeout.connect(_on_timeout)
	add_child(timer)
	
	_update_time()
	
func _on_timeout():
	time_in_sec += 1
	_update_time()
	
func _update_time():
	var minutes: int= floor(time_in_sec / 60)
	var seconds: int = time_in_sec - minutes * 60
	text = "%s:%s" % [_time_str(minutes), _time_str(seconds)]
	
func _time_str(time: int):
	if time < 10:
		return "0%s" % time
	return "%s" % time
