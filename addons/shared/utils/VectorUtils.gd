class_name VectorUtils


static func find_orthogonal_line(points: Array, dir: Vector2, close_point = null, min_gap = 1, max_gap = 50) -> Array:
	var selected_angle = -1
	var selected_left = null
	var selected_right = null
	
	var angle_offset = 90
	
	if close_point != null:
		points.sort_custom(VectorSort.new(close_point), "sort_closest")
	
	for left in points:
		for right in points:
			var distance = left.distance_to(right)
			
			var left_to_right = left.direction_to(right)
			var angle = abs(rad2deg(left_to_right.angle_to(dir)))
			
			var angle_diff = abs(90 - angle)
			var selected_diff = abs(90 - selected_angle)
			
			if distance >= min_gap and distance <= max_gap and angle_diff < selected_diff:
				selected_angle = angle
				selected_left = left
				selected_right = right

	if selected_left == null:
		return []
	
	return [selected_left, selected_right]


static func find_points_around(all_points: Array, search_points: Array, boundary_size = 5.0) -> Dictionary:
	var result = {}
	
	var boundaries = {}
	for point in search_points:
		var boundary = Rect2(point, Vector2.ZERO).grow(boundary_size)
		result[point] = []
		boundaries[point] = boundary
		
	for point in all_points:
		for search_point in boundaries:
			var boundary = boundaries[search_point]
			# print(str(boundary) + " has point " + str(point) + " = " + str(boundary.has_point(point)))
			if boundary.grow(0.0001).has_point(point):
				if result.has(search_point):
					result[search_point].append(point)
				else:
					print("Cannot add point to boundary result")

	
	return result
