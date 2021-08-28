extends Node

export var enemy_path: NodePath
onready var enemy: Enemy = get_node(enemy_path) if enemy_path else owner

export var skeleton_count := 5
export var spawn_distance_from_caster := 10
export var spawn_distance_start := 200

onready var enemies_node := $Enemies
onready var spawn_timer := $SpawnTimer

const skeleton := preload("res://src/enemy/Skeleton.tscn")

var angle: float
var spawn_pos: Vector2
var spawn_count: int


func _existing_skeletons() -> int:
	return enemies_node.get_child_count()


func _distance_to_player() -> float:
	return enemy.global_position.distance_to(enemy.player.global_position)


func _process(delta):
	if _existing_skeletons() != 0 or spawn_count != 0 or _distance_to_player() > spawn_distance_start: return
	
	_start_spawn()


func _start_spawn():
	angle = deg2rad(360.0 / skeleton_count)
	spawn_pos = Vector2.UP * spawn_distance_from_caster
	spawn_count = 0
	_spawn()


func _spawn():
	var instance = skeleton.instance()
	enemies_node.add_child(instance)
	instance.player = enemy.player
	instance.global_position = enemy.global_position + spawn_pos
	spawn_pos = spawn_pos.rotated(angle)
	spawn_count += 1
	
	if spawn_count != skeleton_count:
		spawn_timer.start()
	else:
		spawn_count = 0


func _on_SpawnTimer_timeout():
	_spawn()
