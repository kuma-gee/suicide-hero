extends UnitTest

func test_linear():
	var eq = EquationFactory.linear(Vector2.ZERO, Vector2(1, 1))
	assert_true(eq is LinearEquation)
	assert_eq(eq.rise, 1.0)
	assert_eq(eq.offset, 0.0)
