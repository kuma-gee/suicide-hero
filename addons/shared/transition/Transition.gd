extends Control

export var playback_speed := 1.0
export var reverse := false

onready var anim := $AnimationPlayer

func _ready():
	anim.playback_speed = playback_speed
	var animation = "Reverse" if reverse else "Start"
	anim.play(animation)
