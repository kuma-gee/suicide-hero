extends Node2D

@export var skill: UpgradeResource.Skill
@export var arrow: PackedScene
@export var firerate_timer: Timer
@export var shoot_sound: AudioStreamPlayer
@export var upgrade: BowUpgradeResource

var firerate := 1.0
var damage := 5
var count := 1
var pierce := false
var knockback_force = 0
var speed := 1.0

var _can_fire = true
var _level = 0
var _logger = Logger.new("Bow")

func get_upgrade():
	return upgrade

func apply(res: UpgradeResource):
	var bow = res as BowUpgradeResource
	if bow:
		firerate *= bow.firerate
		damage *= bow.damage
		count += bow.count
		if bow.pierce:
			pierce = true
		knockback_force += bow.knockback_force
		upgrade = bow.next_upgrade
		_level += 1
	
		_logger.info("Upgrading Bow to level %s" % _level)


func activate(player: PlayerResource):
	if not _can_fire: return
	
	_can_fire = false
	
	var angles = _calc_angle()
	for i in range(0, count):
		var angle = angles[i]
		var arrow_node = _create_arrow(angle)
		arrow_node.set_damage(damage * player.attack)
		get_tree().current_scene.add_child(arrow_node)
	shoot_sound.play()
	
	firerate_timer.start(firerate)

func _calc_angle():
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
	node.pierce = pierce
	node.set_knockback(knockback_force)
	return node

func _on_fire_rate_timeout():
	_can_fire = true
