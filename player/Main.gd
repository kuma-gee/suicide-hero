extends Node

export var max_enemies = 200

onready var hud := $HUD
onready var stats := $Player/PlayerStats
onready var player := $Player
onready var map := $Map
onready var experience_timer := $ExperienceTimer
onready var skill_manager := $SkillManager

var enemy_eq = ExponentialEquation.new(2, 1, 30, 2)
var exp_eq = ExponentialEquation.new(0.5, 1.5, 0.5, 2)

func _ready():
	_on_Player_level_up(1)
	experience_timer.start()
	hud.connect_player_stats(stats)

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		GUI.open_menu(GUI.Pause)


func _on_ExperienceTimer_timeout():
	experience_timer.start()


func _on_Player_skill_selected(skill):
	skill_manager.add_skill(skill)


func _on_Player_died():
	GUI.open({"menu": GUI.GameOver, "score": stats.level})


func _on_Player_level_up(lvl):
	map.max_enemy_value = min(enemy_eq.y(lvl-1), max_enemies)
	experience_timer.wait_time = exp_eq.y(lvl-1)
	
	if lvl != 1:
		var skills = skill_manager.get_random_skills(lvl)
		if skills.size() == 2:
			player.skills(skills[0], skills[1])
