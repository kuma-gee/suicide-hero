class_name FadeEffect extends Effect

const _start = Color(1, 1, 1, 1)
const _end = Color(1, 1, 1, 0)

func start():
	.interpolate("modulate", _start, _end)
