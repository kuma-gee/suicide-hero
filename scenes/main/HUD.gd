extends CanvasLayer

onready var health := $Root/Bottom/PanelContainer/MarginContainer/VBoxContainer/HealthBar
onready var experience := $Root/Bottom/PanelContainer/MarginContainer/VBoxContainer/ExpBar
onready var level := $Root/Bottom/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Level

func connect_player_stats(stats: PlayerStats) -> void:
	set_level(stats.level)
	stats.connect("level_up", self, "set_level")
	
	health.connect_value_fill(stats.health)
	experience.connect_value_fill(stats.experience)

func set_level(lvl: int) -> void:
	level.text = tr("LEVEL") + ": " + str(lvl)
