class_name AirGust
extends Area2D

@export var firerate: FireRateTimer
@export var gust: PackedScene

@onready var collision: CollisionShape2D = $CollisionShape2D

var player: Player
var _res: AirGustUpgradeResource

func _ready():
	player.attack_speed_changed.connect(_update_firerate)
	area_entered.connect(_on_area_enter)
	area_exited.connect(_on_area_exit)
	firerate.timeout.connect(_shoot_gust)
	collision.disabled = true


func _on_area_enter(area: Area2D):
	_apply_debuff(area)


func _on_area_exit(area: Area2D):
	_remove_debuff(area)


func _update_debuff():
	for area in get_overlapping_areas():
		_apply_debuff(area)


func _apply_debuff(area: Area2D):
	if area is Debuffer:
		area.set_movement("AirGust", _res.slow_movement)


func _remove_debuff(area: Area2D):
	if area is Debuffer:
		area.set_movement("AirGust", 0)


func _update_slow_radius(radius: int):
	var shape = collision.shape as CircleShape2D
	shape.radius = radius
	# TODO: sprites/animation

func get_resource():
	return _res
	
func apply(res: AirGustUpgradeResource) -> void:
	_res = res
	_update_firerate()
	collision.disabled = false
	_update_slow_radius(_res.slow_radius)
	_update_debuff()

func _update_firerate():
	firerate.update_firerate(_res.firerate * player.get_attack_speed_multiplier())

func _shoot_gust():
	for i in range(0, _res.gust_amount):
		var dir = Vector2.UP.rotated(TAU * randf())
		var node = gust.instantiate()

		node.knockback = _res.knockback
		node.dir = dir
		
		node.global_position = global_position
		get_tree().current_scene.add_child(node)
		
		# TODO: add small delay
