extends Node2D

export var max_enemy_value = 50
export var min_small_enemies = 10

export var player_path: NodePath
onready var player: Player = get_node(player_path)

export var camera_path: NodePath
onready var camera: Camera2D = get_node(camera_path)

onready var tilemap := $TileMap
onready var enemy_spawn_timer := $EnemySpawnTimer
onready var spawn_positions := $SpawnPositions
onready var enemies := $Enemies

const enemy_level_map = {
	1: [
		preload("res://enemy/TinyZombie.tscn"),
		preload("res://enemy/Imp.tscn"),
		preload("res://enemy/Goblin.tscn"),
	],
	5: [
		preload("res://enemy/Orc.tscn"),
		preload("res://enemy/MaskedOrc.tscn"),
	],
	7: [
		preload("res://enemy/Necromancer.tscn"),
		preload("res://enemy/Swampy.tscn"),
	]
}

var _total_small_enemies: int
var _total_stronger_enemies: int

func _get_total_enemy_value() -> int:
	var result := 0
	_total_small_enemies = 0
	_total_stronger_enemies = 0
	for enemy in enemies.get_children():
		if enemy.enemy_value == 1:
			_total_small_enemies += 1
		elif enemy.enemy_value > 1:
			_total_small_enemies += 1
		result += enemy.enemy_value
	return result


func _on_EnemySpawnTimer_timeout():
	if _get_total_enemy_value() >= max_enemy_value: return
	
	_spawn_enemy()

func _spawn_enemy():
	var pos = _get_random_position()
	if pos:
		var node = _get_random_enemy().instance()
		node.player = player
		enemies.add_child(node)
		node.global_position = pos
	else:
		print("No position found. Cannot spawn enemy")

func _get_random_enemy():
	var need_smaller_enemies = _total_stronger_enemies > 1 and _total_small_enemies < min_small_enemies
	var enemies = enemy_level_map[1] if need_smaller_enemies else _get_available_enemies()
	return enemies[Random.random_int(0, enemies.size())]
	
func _get_available_enemies() -> Array:
	var enemies = []
	for lvl in enemy_level_map:
		if player.stats.level >= lvl:
			enemies.append_array(enemy_level_map[lvl])
	return enemies

func _get_random_position():
	var pos = _get_spawn_positions()
	if pos.size() == 0: return null
	return pos[Random.random_int(0, pos.size())]
	
func _get_spawn_positions() -> Array:
	var result = []
	for child in spawn_positions.get_children():
		if child is SpawnPoint and child.enabled:
			result.append(child.global_position)
	return result
