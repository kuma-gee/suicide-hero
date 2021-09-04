extends Control

export var action: String

onready var label_sprite := $LabelSprite
onready var input_key := $InputKey

func _ready():
	input_key.connect("input_text", label_sprite, "set_label")
	input_key.connect("input_texture", label_sprite, "set_label")
	
	input_key.key = InputManager.get_profile().get_input(action.to_lower())
