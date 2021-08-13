extends UnitTest

class TestFindOrthogonalLine extends UnitTest:
	func test_find_invalid():
		assert_eq(VectorUtils.find_orthogonal_line([], Vector2(1, 1)), [])
		assert_eq(VectorUtils.find_orthogonal_line([Vector2.ZERO], Vector2(1, 1)), [])

	func test_find_min_distance():
		assert_eq(VectorUtils.find_orthogonal_line([Vector2.ZERO, Vector2.ZERO], Vector2(1, 1)), [])
		assert_eq(VectorUtils.find_orthogonal_line([Vector2.ZERO, Vector2(10, 10)], Vector2(1, 1)).size(), 2)

	func test_find_max_distance():
		assert_eq(VectorUtils.find_orthogonal_line([Vector2.ZERO, Vector2(10, 10)], Vector2(1, 1), null, 1, 1), [])

	func test_find_with_best_angle():
		var points = [
			Vector2(0, 0),
			Vector2(1, -2),
			Vector2(1, 2),
			Vector2(1, -1),
			Vector2(1, 0),
		]
		var result = VectorUtils.find_orthogonal_line(points, Vector2(1, 1))

		assert_array_eq(result, [Vector2(0, 0), Vector2(1, -1)])

	func test_find_closest_to_point():
		var points = [
			Vector2(0, 0),
			Vector2(0, 1),
			Vector2(0, 5),
			Vector2(0, 6),
		]
		var result = VectorUtils.find_orthogonal_line(points, Vector2(1, 1), Vector2(0, 7))
		assert_array_eq(result, [Vector2(0, 5), Vector2(0, 6)])


class TestFindPointsAround extends UnitTest:
	func test_find_around_single_point():
		var points = [Vector2(1, 1), Vector2(0, 1), Vector2(1, 0), Vector2(10, 0), Vector2(0, 0)]
		var groups = VectorUtils.find_points_around(points, [Vector2.ZERO], 1)

		assert_array_eq(groups.get(Vector2.ZERO), [Vector2(1, 1), Vector2(0, 1), Vector2(1, 0), Vector2(0, 0)]);

	func test_find_around_multiple_points():
		var points = [Vector2(0, -1), Vector2(0, 1), Vector2(0, 3), Vector2(0, 5), Vector2(0, 7)]
		var groups = VectorUtils.find_points_around(points, [Vector2.ZERO, Vector2(0, 6)], 1)

		assert_array_eq(groups.get(Vector2.ZERO), [Vector2(0, -1), Vector2(0, 1)]);
		assert_array_eq(groups.get(Vector2(0, 6)), [Vector2(0, 5), Vector2(0, 7)]);

	func test_find_around_negative_points():
		var points = [Vector2(-10, -10), Vector2(-5, 5), Vector2(10, -5), Vector2(15, 10), Vector2(10, -15)]
		var groups = VectorUtils.find_points_around(points, [Vector2.ZERO], 10)

		assert_array_eq(groups.get(Vector2.ZERO), [Vector2(-10, -10), Vector2(-5, 5), Vector2(10, -5)]);