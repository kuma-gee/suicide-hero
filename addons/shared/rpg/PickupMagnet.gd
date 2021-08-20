class_name PickupMagnet extends Area2D

export var speed = 300

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
