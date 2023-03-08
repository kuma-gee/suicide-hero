class_name SpikeThrow
extends Node2D

@export var spike: PackedScene
@export var resource: SpikeUpgradeResource
@export var firerate: FireRateTimer
@export var player: Player = owner

var _logger = Logger.new("SpikeThrow")

func _ready():
	firerate.timeout.connect(_throw_spikes)

func get_upgrade():
	return null

func apply(res: UpgradeResource):
	var upgrade = res as SpikeUpgradeResource
	if upgrade :
		resource = upgrade
		firerate.set_firerate(resource.firerate)
		_logger.debug("Upgrading Spike Throw")


func _throw_spikes():
	if resource == null: return

	for i in range(0, resource.throw_amount):
		var dir = Vector2.UP.rotated(TAU * randf())
		
		var node = spike.instantiate()
		node.damage = resource.damage * player.get_attack_multiplier()
		node.amount = resource.spike_amount
		node.radius = resource.spike_spread_radius
		node.lifetime = resource.lifetime
		node.speed = resource.throw_force
		
		node.dir = dir
		node.global_position = global_position
		get_tree().current_scene.add_child(node)
		
		_logger.debug("Spawning spike with dir %s" % dir)
	
