class_name Bow
extends Node2D

@export var arrow: PackedScene
@export var firerate: FireRateTimer
@export var shoot_sound: AudioStreamPlayer
@export var player: Player = owner

var _res: BowUpgradeResource

func _ready():
	firerate.timeout.connect(_shoot)

func apply(res: BowUpgradeResource):
	_res = res
	firerate.update_firerate(res.firerate)

func _shoot():
	var res = _res()
	var arrow_count = res.count
	var angles = _calc_angle(arrow_count)
	for i in range(0, arrow_count):
		var angle = angles[i]
		var arrow_node = _create_arrow(angle)
		arrow_node.set_damage(res.damage * player.get_attack_multiplier())
		arrow_node.pierce = res.pierce
		arrow_node.speed = res.speed
		arrow_node.set_knockback(res.knockback_force)
		arrow_node.scale = Vector2(res.scale, res.scale)
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
