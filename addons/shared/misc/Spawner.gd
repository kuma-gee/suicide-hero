class_name Spawner extends Node

signal spawned()

export(Array, PackedScene) var scene: Array
export var spawn_delay = 1.0
export var spawn = false

export(Array, float) var scene_spawn_rate: Array

export var spawn_pos_path: NodePath
onready var spawn_pos := get_node(spawn_pos_path) if spawn_pos_path else null

onready var timer = $Timer

var _can_spawn = true

func _ready():
	if scene_spawn_rate.size() < scene.size():
		var current_sum = 0.0
		for rate in scene_spawn_rate:
			current_sum += rate
		
		var missing_rates = scene.size() - scene_spawn_rate.size()
		var rate = (1 - current_sum) / missing_rates
		for i in range(0, missing_rates):
			current_sum += rate
			scene_spawn_rate.append(current_sum)


func set_spawn(value):
	spawn = value


func _process(delta):
	if spawn and _can_spawn:
		_spawn_all()


func _get_random_scene() -> PackedScene:
	var rand = Random.random_double()
	
	var rate_sum = 0
	for i in range(0, scene.size()):
		rate_sum = scene_spawn_rate[i]
		if rand <= rate_sum:
			return scene[i]
	
	return null


func _spawn_all():
	_spawn()

	emit_signal("spawned")
	_can_spawn = false
	timer.start(spawn_delay)


func _spawn():
	var instance = _instance_scene() as Node
	get_tree().current_scene.add_child(instance)
	if instance.has_method("setup"):
		instance.setup()
	
	if instance is Spatial and spawn_pos is Spatial:
		instance.global_transform = spawn_pos.global_transform
	elif instance is Node2D and spawn_pos is Node2D:
		instance.global_transform = spawn_pos.global_transform
		instance.global_rotation = spawn_pos.global_rotation
	
	return instance

func _instance_scene():
	var scene = _get_random_scene()
	if not scene: return
	
	return scene.instance()

func _on_Timer_timeout():
	_can_spawn = true
