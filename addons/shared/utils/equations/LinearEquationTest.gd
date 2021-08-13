extends UnitTest

func test_y_value():
	var eq = LinearEquation.new(1, 0)
	assert_eq(eq.y(0), 0)
	assert_eq(eq.y(1), 1)
	assert_eq(eq.y(2), 2)
