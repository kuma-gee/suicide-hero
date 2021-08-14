extends UnitTest

func test_start_empty():
	var value := _value_fill(100)
	value.start_empty = true
	add_child(value)
	
	assert_eq(value.value, 0)
	assert_eq(value.max_value, 100)


func _value_fill(max_value: int) -> ValueFill:
	var value: ValueFill = autofree(ValueFill.new())
	value.max_value = max_value
	return value


class TestValueFillOverflow extends UnitTest:
	var value: ValueFill
	
	func before_each():
		value = autofree(ValueFill.new())
		value.max_value = 5
		value.overflow = true
		watch_signals(value)
	
	func test_overflow_once():
		value.increase(8)
		
		assert_signal_emit_count(value, "overflow", 1)
		assert_signal_emitted(value, "value_changed", 3)
		assert_signal_emit_count(value, "value_changed", 1)
	
	func test_overflow_multiple():
		value.increase(16)
		
		assert_signal_emit_count(value, "overflow", 3)
		assert_signal_emitted(value, "value_changed", 1)
		assert_signal_emit_count(value, "value_changed", 1)
		
	func test_overflow_exact():
		value.increase(5)
		
		assert_signal_emitted(value, "overflow")
		assert_signal_emitted(value, "value_changed", 0)
	

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
		value.max_value = 5
		value.value = 1
		value.value = 0
		assert_signal_emitted(value, "zero_value")

	func test_emit_value_changed():
		value.value = 2
		assert_signal_emitted_with_parameters(value, "value_changed", [2])

	func test_set_max_value():
		value.max_value = 2
		assert_eq(value.max_value, 2)

	func test_not_set_max_value_below_one():
		value.max_value = 0
		assert_eq(value.max_value, 1)

	func test_emit_max_value_changed():
		value.max_value = 2
		assert_signal_emitted_with_parameters(value, "max_value_changed", [2])

	func test_emit_full_value():
		value.max_value = 5
		value.value = 5
		
		assert_signal_emitted(value, "full_value")

	func test_not_emit_full_value_if_no_increase():
		value.max_value = 5
		value.value = 5
		value.increase(0)
		
		assert_signal_emit_count(value, "full_value", 1)
