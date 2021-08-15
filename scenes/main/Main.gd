extends Node

export var max_enemies = 200

onready var hud := $HUD
onready var stats := $PlayerStats
onready var player := $Player
onready var map := $Map
onready var experience_timer := $ExperienceTimer

var enemy_eq = ExponentialEquation.new(2, 1, 20, 2)
var spawn_eq = ExponentialEquation.new(0.5, 1.5, 0.5, 2)

func _ready():
	Game.connect("game_start", self, "start")
	Game.connect("game_ended", self, "end")
	
	_on_PlayerStats_level_up(1)
	experience_timer.start()
	hud.connect_player_stats(stats)


func start():
	GUI.open_menu(GUI.InGame, true)


func end():
	get_tree().change_scene("res://scenes/menu/Menu.tscn")


func _on_Health_zero_value():
	GUI.open({"menu": GUI.GameOver, "score": stats.level})


func _on_PlayerStats_level_up(lvl):
	map.max_enemy_value = min(enemy_eq.y(lvl-1), max_enemies)
	experience_timer.wait_time = spawn_eq.y(lvl-1)


func _on_ExperienceTimer_timeout():
	experience_timer.start()
