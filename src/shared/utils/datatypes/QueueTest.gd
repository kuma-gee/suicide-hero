extends UnitTest

var queue: Queue

func before_each():
	queue = autofree(Queue.new())
	watch_signals(queue)

func test_queue():
	queue.queue("First")
	queue.queue("Second")
	
	assert_eq(queue.deque(), "First")
	assert_eq(queue.deque(), "Second")

func test_auto_deque():
	queue.auto_deque = true
	queue.queue("First")
	queue.queue("Second")
	queue.queue("Third")
	
	simulate(queue, 1, 1)
	assert_signal_emitted_with_parameters(queue, "dequed", ["First"])
	
	simulate(queue, 1, 1)
	assert_signal_emitted_with_parameters(queue, "dequed", ["Second"])
