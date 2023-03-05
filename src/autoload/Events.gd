extends Node

signal font_size_changed()
signal skill_selected()
signal player_stats_changed()

var player_stats: PlayerResource : set = _set_player_stats

func _set_player_stats(res: PlayerResource):
	player_stats = res
