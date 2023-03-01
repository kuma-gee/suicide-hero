extends Node

@export var max_enemies = 200

@onready var hud := $HUD
@onready var map := $Map
@onready var skill_manager := $SkillManager
@onready var enemy_manager: EnemyManager = $EnemyManager
@onready var camera := $Camera2D
@onready var player := $Player

const PLAYER = preload("res://src/player/Player.tscn")

var enemy_eq = ExponentialEquation.new(2, 1, 30, 2)
var exp_eq = ExponentialEquation.new(0.5, 2, 0.5, 3)

func _ready():
	GUI.open_menu(GUI.Intro, true)
	
	if Env.is_prod():
		randomize()
		
	player.global_position = map.get_player_spawn()
	map.player = player
	skill_manager.player = player
	enemy_manager.player = player
	
	_on_player_level_up(1)
	hud.connect_player_stats(player.stats)

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		GUI.open_menu(GUI.Pause)


func _on_player_skill_selected(skill):
	skill_manager.add_skill(skill)


func _on_player_died():
	GUI.open({"menu": GUI.GameOver, "score": player.stats.level})


func _on_player_level_up(lvl):
#	map.max_enemy_value = min(enemy_eq.y(lvl-1), max_enemies)
	
	if lvl != 1:
		var skills = skill_manager.get_random_skills(lvl)
		if skills.size() == 2:
			player.skills(skills[0], skills[1])
