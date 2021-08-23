extends UnitTest

var stack: Stack

func before_each():
	stack = autofree(Stack.new())
	watch_signals(stack)


func test_stack():
	stack.push("Item 1")
	assert_eq(stack.current, "Item 1")
	assert_signal_emitted_with_parameters(stack, "added", ["Item 1"])
	
	stack.push("Item 2")
	assert_eq(stack.current, "Item 2")
	assert_signal_emitted_with_parameters(stack, "added", ["Item 2"])
	
	stack.pop()
	assert_eq(stack.current, "Item 1")
	assert_signal_emitted_with_parameters(stack, "removed", ["Item 2"])
	
	stack.pop()
	assert_null(stack.current)
	assert_signal_emitted_with_parameters(stack, "removed", ["Item 1"])
	
	stack.pop()
	assert_null(stack.current)
	assert_signal_emit_count(stack, "removed", 2)
	
