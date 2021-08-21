class_name Effect extends Component

signal finished()

export var start := false
export var delay := 0.0
export var duration := 1.0
export var reverse := false

var tween: Tween

func _ready():
	tween = Tween.new()
	add_child(tween)
	if start:
		start()

func interpolate(property: String, initial, final) -> void:
	var initial_value = final if reverse else initial
	var final_value = initial if reverse else final
	tween.interpolate_property(node, property, initial_value, final_value, duration, Tween.TRANS_QUAD, Tween.EASE_IN_OUT, delay)
	tween.start()
	tween.connect("tween_all_completed", self, "_finished")
	
func _finished():
	emit_signal("finished")

func start():
	pass
