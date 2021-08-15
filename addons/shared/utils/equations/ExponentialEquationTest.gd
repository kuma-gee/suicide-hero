extends UnitTest

func test_y_value():
	var eq = ExponentialEquation.new(0.5, 1.5, 0.5, 2)
	assert_eq(eq.y(0), 2.0)
	assert_eq(eq.y(2), 5.0/4.0)
	assert_eq(eq.y(4), 7.0/8.0)
