class_name Bomb
extends Node2D

@export var firerate: FireRateTimer
@export var bomb: PackedScene

var player: Player
var _logger = Logger.new("Bomb")
var _res: BombUpgradeResource

func _ready():
	firerate.timeout.connect(_throw_bombs)

func apply(res: BombUpgradeResource):
	_res = res
	firerate.update_firerate(_res.firerate)
	_logger.debug("Upgrading Bombs")


func _throw_bombs():
	if _res== null: return

	for i in range(0, _res.throw_amount):
		var dir = Vector2.UP.rotated(TAU * randf())
		
		var node = bomb.instantiate()
		node.damage = _res.damage
		node.radius = _res.explosion_radius

		node.speed = _res.throw_force
		node.dir = dir
		node.global_position = player.global_position
		get_tree().current_scene.add_child(node)
		
		_logger.debug("Spawning bomb with dir %s" % dir)
	

func get_resource():
	return _res
