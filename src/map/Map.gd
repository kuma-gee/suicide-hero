extends Node2D

@export var spawn_positions: Node2D
@export var player: Player

@export var enemies: Array[EnemyResource]

@onready var tilemap := $TileMap

const ENEMY_SCENE = preload("res://src/enemy/Enemy.tscn")

var _logger = Logger.new("Map")
var _enemy_pool: Array[EnemyResource] = [] # TODO: add weight?

func _ready():
	_add_enemy_to_pool()


func _process(delta):
	tilemap.update_for_position(player.global_position)


func _on_spawn_timer_timeout():
	var points = _get_possible_spawn_points()
	var random_point = points[randi() % points.size()]

	var enemy = ENEMY_SCENE.instantiate()
	enemy.resource = _enemy_pool[randi() % _enemy_pool.size()]
	enemy.global_position = random_point.global_position
	enemy.player = player
	_logger.trace("Spawn enemy at %s" % random_point.global_position)
	add_child(enemy)

# TODO: get spawn around player
func _get_possible_spawn_points():
	var vel = player.velocity if player else Vector2.ZERO
	var center = spawn_positions.global_position
	var result = []

	for child in spawn_positions.get_children():
		var dir_to_point = center.direction_to(child.global_position)
		if vel.length() == 0 or vel.dot(dir_to_point) > 0:
			result.append(child)
	
	return result


func _on_new_enemy_timer_timeout():
	if enemies.size() > 0:
		_add_enemy_to_pool()

func _add_enemy_to_pool():
	_enemy_pool.append(enemies.pop_front())


func get_player_spawn():
	return tilemap.get_center_position()
