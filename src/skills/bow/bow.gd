class_name Bow
extends Skill

@export var arrow: PackedScene
@export var firerate: FireRateTimer
@export var shoot_sound: AudioStreamPlayer

@export var resource := BowUpgradeResource.new()

var _level = 0
var _logger = Logger.new("Bow")

func get_upgrade():
	return null

func apply(res: UpgradeResource):
	var bow = res as BowUpgradeResource
	if bow:
		resource = bow
#		upgrade = bow.next_upgrade
		_level += 1
	
		_logger.info("Upgrading Bow to level %s" % _level)

func activate(player: PlayerResource):
	if not firerate.can_fire(resource.firerate): return
	
	var arrow_count = resource.count
	var angles = _calc_angle(arrow_count)
	for i in range(0, arrow_count):
		var angle = angles[i]
		var arrow_node = _create_arrow(angle)
		arrow_node.set_damage(resource.damage * player.get_attack_multiplier())
		arrow_node.pierce = resource.pierce
		arrow_node.speed = resource.speed
		arrow_node.set_knockback(resource.knockback_force)
		arrow_node.scale = Vector2(resource.scale, resource.scale)
		get_tree().current_scene.add_child(arrow_node)
	shoot_sound.play()

func _calc_angle(count: int):
	if count == 1:
		return [0]
	if count == 2:
		var diff = deg_to_rad(10.0 / count)
		return [-diff, diff]
	
	var diff = deg_to_rad(45.0 / count)
	return [-diff, 0, diff]

func _create_arrow(angle):
	var node = arrow.instantiate()
	node.global_transform = global_transform
	node.global_rotation = global_rotation + angle
	return node
