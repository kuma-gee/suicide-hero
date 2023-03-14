class_name SpikeThrow
extends Node2D

@export var spike: PackedScene
@export var firerate: FireRateTimer

var player: Player
var _logger = Logger.new("SpikeThrow")
var _res: SpikeUpgradeResource

func _ready():
	player.attack_speed_changed.connect(_update_firerate)
	firerate.timeout.connect(_throw_spikes)

func get_resource():
	return _res

func apply(res: SpikeUpgradeResource):
	_res = res
	_update_firerate()
	_logger.debug("Upgrading Spike Throw")
	_throw_spikes()

func _update_firerate():
	firerate.update_firerate(_res.firerate * player.get_attack_speed_multiplier())


func _throw_spikes():
	_logger.debug("Throwing spikes")
	
	for i in range(0, _res.throw_amount):
		var dir = Vector2.UP.rotated(TAU * randf())
		
		var node = spike.instantiate()
		node.damage = _res.damage * player.get_attack_multiplier()
		node.amount = _res.spike_amount
		node.radius = _res.spike_spread_radius
		node.lifetime = _res.lifetime
		node.speed = _res.throw_force
		
		node.dir = dir
		node.global_position = global_position
		get_tree().current_scene.add_child(node)
		
		_logger.debug("Spawning spike with dir %s" % dir)
	
