class_name PickupMagnet extends Area2D

@export var speed = 300

@onready var shape = $CollisionShape2D

var items = []

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

func set_range(value: float):
	var circle = shape.shape as CircleShape2D
	circle.radius = value

func get_range():
	return shape.shape.radius
