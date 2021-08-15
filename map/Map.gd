extends Node2D

export var max_enemy_value = 50

export var player_path: NodePath
onready var player: Node2D = get_node(player_path)

export var camera_path: NodePath
onready var camera: Camera2D = get_node(camera_path)

onready var tilemap := $TileMap
onready var enemy_spawn_timer := $EnemySpawnTimer
onready var spawn_positions := $SpawnPositions
onready var enemies := $Enemies

const enemy = preload("res://enemy/TinyZombie.tscn")

enum {
	FLOOR,
	WALL,
}


func _get_total_enemy_value() -> int:
	var result := 0
	for enemy in enemies.get_children():
		result += enemy.enemy_value
	return result


func _on_EnemySpawnTimer_timeout():
	if _get_total_enemy_value() >= max_enemy_value: return
	
	_spawn_enemy()

func _spawn_enemy():
	var pos = _get_random_position()
	if pos:
		var node = enemy.instance()
		node.player = player
		enemies.add_child(node)
		node.global_position = pos
	else:
		print("No position found. Cannot spawn enemy")

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
