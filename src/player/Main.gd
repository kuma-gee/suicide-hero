extends Node

@onready var hud := $HUD
@onready var map := $Map
@onready var camera := $Camera2D
@onready var player := $Player

func _ready():
	if Env.is_prod():
		randomize()
	
	GUI.clear()
	player.global_position = map.get_player_spawn()
	map.player = player
	
	hud.connect_player_stats(player.stats)
	hud.connect_skill_stats(player.skill_manager)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		GUI.open_menu(GUI.Pause)


func _on_player_died():
	GUI.open({"menu": GUI.GameOver, "score": player.stats.level})
