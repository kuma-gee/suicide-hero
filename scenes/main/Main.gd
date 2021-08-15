extends Node

onready var hud := $HUD
onready var stats := $PlayerStats

func _ready():
	Game.connect("game_start", self, "start")
	Game.connect("game_ended", self, "end")
	
	hud.connect_player_stats(stats)


func start():
	GUI.open_menu(GUI.InGame, true)


func end():
	get_tree().change_scene("res://scenes/menu/Menu.tscn")


func _on_Health_zero_value():
	GUI.open({"menu": GUI.GameOver, "score": stats.level})
