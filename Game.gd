extends Node

signal game_ready()
signal game_start()
signal game_ended()
signal score_changed(score)

var game_started = false
var score = 0 setget _set_score


func start_game():
	game_started = true
	emit_signal("game_start")


func end_game():
	game_started = false
	emit_signal("game_ended")

func _set_score(value: int):
	score = value
	emit_signal("score_changed", score)
