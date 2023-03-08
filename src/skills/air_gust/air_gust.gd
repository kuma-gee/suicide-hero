class_name AirGust
extends Area2D

@export var resource: AirGustUpgradeResource
@export var firerate: FireRateTimer
@export var gust: PackedScene

@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready():
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
		area.set_movement("AirGust", resource.slow_movement)


func _remove_debuff(area: Area2D):
	if area is Debuffer:
		area.set_movement("AirGust", 0)


func _update_slow_radius(radius: int):
	var shape = collision.shape as CircleShape2D
	shape.radius = radius
	# TODO: sprites/animation


func get_upgrade():
	return null

func apply(res: UpgradeResource) -> void:
	var upgrade = res as AirGustUpgradeResource
	if upgrade:
		resource = upgrade
		collision.disabled = false
		firerate.set_firerate(resource.firerate)
		_update_debuff()

func _shoot_gust():
	for i in range(0, resource.gust_amount):
		var dir = Vector2.UP.rotated(TAU * randf())
		var node = gust.instantiate()

		node.knockback = resource.knockback
		node.dir = dir

		node.global_position = global_position
		get_tree().current_scene.add_child(node)