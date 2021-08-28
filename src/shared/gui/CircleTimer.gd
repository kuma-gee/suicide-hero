extends TextureProgress

signal timeout

export var time := 1.0
onready var timer := $Timer

func _ready():
	hide()

func start() -> void:
	timer.start(time)
	value = max_value
	show()

func stop() -> void:
	hide()

func _process(_delta):
	if not timer.is_stopped():
		var p = (timer.time_left / time) * max_value
		value = p

func _on_Timer_timeout():
	stop()
	emit_signal("timeout")
