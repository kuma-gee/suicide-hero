class_name PickupMagnet extends Area2D

@export var speed = 300

@onready var shape = $CollisionShape2D

var items = []
var _min_pickup := 10
var _max_pickup := 60

func _physics_process(delta):
	for item in items:
		_move_node(item, delta)
	

func _move_node(node: Node2D, delta: float) -> void:
	var dir := node.global_position.direction_to(global_position)
	dir = dir.normalized()
	
	node.global_position += dir * speed * delta

func _on_PickupMagnet_area_entered(area):
	if area in items: return
	items.append(area)


func _on_PickupMagnet_area_exited(area):
	items.erase(area)

func set_range(percentage: float):
	var extra_radius = (_max_pickup - _min_pickup) * percentage
	var circle = shape.shape as CircleShape2D
	circle.radius = _min_pickup + extra_radius
	
	print("%s - %s - %s" % [circle.radius, extra_radius, percentage])
