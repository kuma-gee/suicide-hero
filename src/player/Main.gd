extends Node

@onready var hud := $HUD
@onready var map := $Map
@onready var camera := $Camera2D
@onready var player := $Player

var killed_enemies := 0

func _ready():
	if Env.is_prod():
		randomize()
	
	GUI.clear()
	player.global_position = map.get_player_spawn()
	map.player = player
	
	hud.connect_player_stats(player.stats)
	_update_kill_count()

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		GUI.open_menu(GUI.Pause)


func _on_player_died():
	GUI.open({"menu": GUI.GameOver, "score": player.stats.level})


func _on_map_enemy_killed():
	killed_enemies += 1
	_update_kill_count()
	
func _update_kill_count():
	hud.update_kills(killed_enemies)
