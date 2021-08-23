extends UnitTest

func test_sort_closest():
	var points = [
		Vector2(0, 0),
		Vector2(1, 0),
		Vector2(20, 0),
		Vector2(13, 0),
		Vector2(6, 0),
		Vector2(9, 0),
	]
	var sort = autofree(VectorSort.new(Vector2(10, 0)))
	
	points.sort_custom(sort, "sort_closest")
	
	assert_eq(points, [
		Vector2(9, 0),
		Vector2(13, 0),
		Vector2(6, 0),
		Vector2(1, 0),
		Vector2(0, 0),
		Vector2(20, 0),
	])
