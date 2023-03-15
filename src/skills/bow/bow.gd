class_name Bow
extends Node2D

@export var arrow: PackedScene
@export var firerate: FireRateTimer
@export var shoot_sound: AudioStreamPlayer

var player: Player
var _res: BowUpgradeResource

func _ready():
	player.attack_speed_changed.connect(_update_firerate)
	firerate.timeout.connect(_shoot)

func get_resource():
	return _res

func apply(res: BowUpgradeResource):
	_res = res
	_update_firerate()

func _update_firerate():
	firerate.update_firerate(_res.firerate)

func _shoot():
	var arrow_count = _res.count
	var angles = _calc_angle(arrow_count)
	for i in range(0, arrow_count):
		var angle = angles[i]
		var arrow_node = _create_arrow(angle)
		arrow_node.set_damage(_res.damage)
		arrow_node.set_crit(player.get_crit_chance())
		arrow_node.pierce = _res.pierce
		arrow_node.speed = _res.speed
		arrow_node.set_knockback(_res.knockback_force)
		arrow_node.scale = Vector2(_res.scale, _res.scale)
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
