class_name Bomb
extends Node2D

@export var resource: BombUpgradeResource
@export var firerate: FireRateTimer
@export var bomb: PackedScene

@export var player: Player = owner

var _logger = Logger.new("Bomb")

func _ready():
	firerate.timeout.connect(_throw_bombs)

func get_upgrade():
	return null

func apply(res: UpgradeResource):
	var upgrade = res as BombUpgradeResource
	if upgrade :
		resource = upgrade
        firerate.update_firerate(resource.firerate)
		_logger.debug("Upgrading Bombs")


func _throw_bombs():
    if resource == null: return

	for i in range(0, resource.throw_amount):
		var dir = Vector2.UP.rotated(TAU * randf())
		
		var node = bomb.instantiate()
		node.damage = resource.damage * player.get_attack_multiplier()
		node.radius = resource.spike_spread_radius

		node.speed = resource.throw_force
		node.dir = dir
		node.global_position = global_position
		get_tree().current_scene.add_child(node)
		
		_logger.debug("Spawning bomb with dir %s" % dir)
	
