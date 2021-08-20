extends MoveDirection2D

var target: Node2D

func set_target(node) -> void:
	if not target:
		target = node

func _physics_process(delta):
	if target:
		move_object.look_at(target.global_position)
		
		var dir = move_object.global_position.direction_to(target.global_position)
		move_object.global_position += dir * delta * speed
	else:
		._physics_process(delta)
