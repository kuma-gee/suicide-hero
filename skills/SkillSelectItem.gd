extends Node2D

var texture: Texture
var key: InputEvent

onready var sprite := $Sprite
onready var label := $CenterContainer/MarginContainer/Label
onready var container := $CenterContainer

func _ready():
	sprite.texture = texture
	if key != null:
		label.text = key.as_text()
		
#	container.rect_position.x -= container.rect_size.x / 2
