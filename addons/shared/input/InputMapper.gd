extends Node

class_name InputMapper

const inputs = {
	"boost": null,
	"fire": null,
	"move_up": null,
	"move_down": null,
	"move_left": null,
	"move_right": null,
}

func _ready():
	InputMap.get_action_list("")
