extends Node

export var max_enemies = 200

onready var hud := $HUD
onready var stats := $Player/PlayerStats
onready var player := $Player
onready var map := $Map
onready var experience_timer := $ExperienceTimer
onready var skill_manager := $SkillManager

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
	
	var skills = skill_manager.get_random_skills(lvl)
	if skills.size() == 2:
		player.skills(skills[0], skills[1])


func _on_ExperienceTimer_timeout():
	experience_timer.start()


func _on_Player_skill_selected(skill):
	skill_manager.add_skill(skill)
