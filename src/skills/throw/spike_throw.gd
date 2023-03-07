class_name SpikeThrow
extends Skill

@export var spike: PackedScene
@export var throw: RandomThrow
@export var resource: SpikeUpgradeResource

var _logger = Logger.new("SpikeThrow")

func get_upgrade():
	return null

func apply(res: UpgradeResource):
	var upgrade = res as SpikeUpgradeResource
	if upgrade :
		resource = upgrade
		_logger.debug("Upgrading Spike Throw")


func activate(res: PlayerResource):
    var dirs = throw.random_throw(resource.throw)
    if dirs.is_empty(): return

    for dir in dirs:
        var node = spike.instantiate()
        node.damage = resource.damage * res.get_attack_multiplier()
        node.max_hits = resource.max_hits
        node.amount = resource.amount
        node.radius = resource.radius

        node.dir = dir
        node.global_position = global_position
        get_tree().current_scene.add_child(node)