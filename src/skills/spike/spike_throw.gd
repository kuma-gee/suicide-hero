class_name SpikeThrow
extends Skill

@export var spike: PackedScene
@export var resource: SpikeUpgradeResource
@export var firerate: FireRateTimer

var _logger = Logger.new("SpikeThrow")

func get_upgrade():
	return null

func apply(res: UpgradeResource):
	var upgrade = res as SpikeUpgradeResource
	if upgrade :
		resource = upgrade
		_logger.debug("Upgrading Spike Throw")


func activate(res: PlayerResource):
	if not firerate.can_fire(resource.firerate): return

	for i in range(0, resource.throw_amount):
		var dir = Vector2.UP.rotated(TAU * randf())
		
		var node = spike.instantiate()
		node.damage = resource.damage * res.get_attack_multiplier()
		node.amount = resource.spike_amount
		node.radius = resource.spike_spread_radius
		node.lifetime = resource.lifetime
		node.force = resource.throw_force
		
		node.dir = dir
		node.global_position = global_position
		get_tree().current_scene.add_child(node)
		
		_logger.debug("Spawning spike with dir %s" % dir)
	
