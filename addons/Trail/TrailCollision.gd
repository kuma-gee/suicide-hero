class_name TrailCollision extends Node

export var trail_path: NodePath
onready var trail: Trail2D = get_node(trail_path) if trail_path else get_parent().get_parent()

export var collision_parent_path: NodePath
onready var collision_parent: Node2D = get_node(collision_parent_path)

func _process(delta):
	update_collision_shape()

func _has_same_position(point: Vector2, points: Array) -> bool:
	for p in points:
		if p == point:
			return true
	return false

func update_collision_shape():
	var points = []
	for p in trail.points:
		points.append(p)
	
	for c in collision_parent.get_children():
		var segment = c.shape as SegmentShape2D
		if _has_same_position(segment.a, points):
			points.erase(segment.a)
			continue

		collision_parent.remove_child(c)
	
	for i in range(0, points.size() - 1):
		var segment = SegmentShape2D.new()
		segment.a = points[i]
		segment.b = points[i+1]
		
		var shape = CollisionShape2D.new()
		shape.shape = segment
		collision_parent.add_child(shape)
	

func _create_points(points: Array) -> Array:
	var result = []
	
	for i in range(0, points.size()):
		var curr_point = points[i]
		
		var is_last = i == points.size() - 1
		var next_point = points[i + 1] if not is_last else points[i - 1]
		
		var dir: Vector2 = next_point - curr_point
		if is_last:
			dir *= -1
		
		var point_dir = VectorUtils.orthogonal(dir).normalized() * -1
		var point = curr_point + point_dir * (trail.width / 2)
		result.append(point)
	return result
