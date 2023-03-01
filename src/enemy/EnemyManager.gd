class_name EnemyManager
extends Node

@export var spawn_points: Node2D
@export var player: Player

@onready var spawn_timer: Timer = $SpawnTimer
@onready var new_enemy_timer: Timer = $NewEnemyTimer

var enemies_by_stage = {
	1: [
		preload("res://src/enemy/TinyZombie.tscn"),
		preload("res://src/enemy/Imp.tscn"),
		preload("res://src/enemy/Goblin.tscn"),
	],
	4: [
		preload("res://src/enemy/Orc.tscn"),
		preload("res://src/enemy/MaskedOrc.tscn"),
	],
	7: [
		preload("res://src/enemy/Necromancer.tscn"),
		# preload("res://src/enemy/Swampy.tscn"),
	]
}

var _logger = Logger.new("EnemyManager")
var _current_enemy_pool = []
var _current_stage = 1

func _ready():
	_add_random_enemy_to_pool()

func _add_random_enemy_to_pool():
	for stage in enemies_by_stage:
		var enemies = enemies_by_stage[stage]
		if stage <= _current_stage and enemies.size() > 0:
			var new_enemy = enemies.pop_at(randi() % enemies.size())
			_current_enemy_pool.append(new_enemy)
			_logger.debug("Adding new enemy to pool: %s" % new_enemy)
			break

func _spawn():
	var points = _get_possible_spawn_points()
	var random_point = points[randi() % points.size()]

	var enemy = _current_enemy_pool[randi() % _current_enemy_pool.size()].instantiate()
	enemy.player = spawn_points # Should be at the center of the screen
	enemy.global_position = random_point.global_position
	get_tree().current_scene.add_child(enemy)
	_logger.debug("Spawned enemy %s at %s" % [enemy, random_point])

func _get_possible_spawn_points():
	var vel = player.velocity if player else Vector2.ZERO
	var center = spawn_points.global_position
	var result = []

	for child in spawn_points.get_children():
		var dir_to_point = center.direction_to(child.global_position)
		if vel.length() == 0 or vel.dot(dir_to_point) > 0:
			result.append(child)
	
	return result


func _on_spawn_timer_timeout():
	_spawn()


func _on_new_enemy_timer_timeout():
	_add_random_enemy_to_pool()
