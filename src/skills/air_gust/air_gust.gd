class_name AirGust
extends Area2D

@export var firerate: FireRateTimer
@export var gust: PackedScene
@export var upgrader: Upgrader

@onready var collision: CollisionShape2D = $CollisionShape2D

func _ready():
	area_entered.connect(_on_area_enter)
	area_exited.connect(_on_area_exit)
	firerate.timeout.connect(_shoot_gust)
	upgrader.upgraded.connect(_on_upgrade)
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
		area.set_movement("AirGust", upgrader.resource.slow_movement)


func _remove_debuff(area: Area2D):
	if area is Debuffer:
		area.set_movement("AirGust", 0)


func _update_slow_radius(radius: int):
	var shape = collision.shape as CircleShape2D
	shape.radius = radius
	# TODO: sprites/animation
	

func get_upgrade():
	return upgrader.get_next_upgrade()

func apply(res: UpgradeResource) -> void:
	if res is AirGustUpgradeResource:
		upgrader.upgrade()
		
func _on_upgrade(res: AirGustUpgradeResource):
	collision.disabled = false
	_update_slow_radius(upgrader.resource.slow_radius)
	firerate.update_firerate(upgrader.resource.firerate)
	_update_debuff()

func _shoot_gust():
	var res = upgrader.resource as AirGustUpgradeResource
	for i in range(0, res.gust_amount):
		var dir = Vector2.UP.rotated(TAU * randf())
		var node = gust.instantiate()

		node.knockback = res.knockback
		node.dir = dir
		
		node.global_position = global_position
		get_tree().current_scene.add_child(node)
		
		# TODO: add small delay
