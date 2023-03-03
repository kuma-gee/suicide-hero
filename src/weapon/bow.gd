extends Node2D

@export var arrow: PackedScene
@export var firerate_timer: Timer
@export var shoot_sound: AudioStreamPlayer

var firerate := .1
var damage := 1
var count := 3
var pierce := true
var knockback_force = 50

var _can_fire = true

func fire():
	if not _can_fire: return
	
	_can_fire = false
	
	var angles = _calc_angle()
	for i in range(0, count):
		var angle = angles[i]
		var arrow_node = _create_arrow(angle)
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
	node.set_damage(damage)
	node.pierce = pierce
	node.set_knockback(knockback_force)
	return node

func _on_fire_rate_timeout():
	_can_fire = true
