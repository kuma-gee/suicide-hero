extends Camera2D

export var zoom_speed = .1
export var border = 5

var nodes = []
var center = Vector2.ZERO
var zoom_out = false

func add_track_node(node: Node2D) -> void:
	nodes.append(node)

func _process(delta):
	_calculate_center()
	global_position = center
	
	if zoom_out:
		print("zoom")
#		zoom += Vector2(zoom_speed, zoom_speed)

func _calculate_center() -> void:
	var left_bottom = null
	var right_top = null
	
	var rect = get_viewport_rect()
	rect.position = global_position
	var do_zoom_out = false
	
	for node in nodes:
		var pos = node.global_position
		
		if not do_zoom_out:
			do_zoom_out = not rect.has_point(pos)
		
		if left_bottom == null:
			left_bottom = pos
			
		if right_top == null:
			right_top = pos
		
		if pos.x <= left_bottom.x:
			left_bottom.x = pos.x
		
		if pos.x >= right_top.x:
			right_top.x = pos.x

		if pos.y >= left_bottom.y:
			left_bottom.y = pos.y
		
		if pos.y <= right_top.y:
			right_top.y = pos.y
	
	zoom_out = do_zoom_out
	if not left_bottom and not right_top:
		return
	
	if nodes.size() == 1:
		center = left_bottom if left_bottom else right_top
	else:
		var diagonal = right_top - left_bottom
		center = left_bottom + (diagonal / 2)
