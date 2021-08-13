extends UnitTest


class TestValueFillUsage extends UnitTest:
	var value: ValueFill

	func before_each():
		value = autofree(ValueFill.new())
		value.max_value = 5
		add_child(value)

	func test_initialize_value():
		assert_eq(value.value, 5)

	func test_reduce_value():
		value.reduce(2)
		assert_eq(value.value, 3)

	func test_increase_value():
		value.max_value = 10
		value.increase(3)
		assert_eq(value.value, 8)
		
	func test_fill_value():
		value.max_value = 10
		value.value = 1
		value.fill()
		assert_eq(value.value, 10)


class TestValueFillSetterEmitter extends UnitTest:
	var value: ValueFill

	func before_each():
		value = autofree(ValueFill.new())
		watch_signals(value)

	func test_set_value():
		value.value = 2
		assert_eq(value.value, 2)

	func test_not_set_above_max_value():
		value.max_value = 5
		value.value = 10
		assert_eq(value.value, 5)

	func test_not_set_negative_value():
		value.value = -1
		assert_eq(value.value, 0)

	func test_emit_zero_value():
		value.value = 0
		assert_signal_emitted(value, "zero_value")

	func test_emit_value_changed():
		value.value = 2
		assert_signal_emitted_with_parameters(value, "value_changed", [2])

	func test_emit_value_changed_on_zero():
		value.value = 0
		assert_signal_emitted_with_parameters(value, "value_changed", [0])

	func test_set_max_value():
		value.max_value = 2
		assert_eq(value.max_value, 2)

	func test_not_set_max_value_below_one():
		value.max_value = 0
		assert_eq(value.max_value, 1)

	func test_emit_max_value_changed():
		value.max_value = 2
		assert_signal_emitted_with_parameters(value, "max_value_changed", [2])
