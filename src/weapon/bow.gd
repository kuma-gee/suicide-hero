extends Node2D

@export var skill: UpgradeResource.Skill
@export var arrow: PackedScene
@export var firerate_timer: Timer
@export var shoot_sound: AudioStreamPlayer
@export var upgrade: BowUpgradeResource

var firerate := 1.0
var count = 1
var speed = 300.0
var damage = 5

@export var _current_upgrade := BowUpgradeResource.new()

var _can_fire = true
var _level = 0
var _logger = Logger.new("Bow")

func get_upgrade():
	return upgrade

func apply(res: UpgradeResource):
	var bow = res as BowUpgradeResource
	if bow:
		_current_upgrade.firerate += bow.firerate
		_current_upgrade.damage += bow.damage
		_current_upgrade.count += bow.count
		_current_upgrade.speed = bow.speed
		if bow.pierce:
			_current_upgrade.pierce = true
		_current_upgrade.knockback_force += bow.knockback_force
			
		upgrade = bow.next_upgrade
		_level += 1
	
		_logger.info("Upgrading Bow to level %s" % _level)

func activate(player: PlayerResource):
	if not _can_fire: return
	
	_can_fire = false
	
	var arrow_count = count + _current_upgrade.count
	var angles = _calc_angle(arrow_count)
	for i in range(0, arrow_count):
		var angle = angles[i]
		var arrow_node = _create_arrow(angle)
		arrow_node.set_damage(damage * (1 + _current_upgrade.damage + player.attack))
		arrow_node.pierce = _current_upgrade.pierce
		arrow_node.speed = speed * (1 + _current_upgrade.speed)
		arrow_node.set_knockback(_current_upgrade.knockback_force)
		get_tree().current_scene.add_child(arrow_node)
	shoot_sound.play()
	
	firerate_timer.start(firerate / (1 + _current_upgrade.firerate))

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

func _on_fire_rate_timeout():
	_can_fire = true
