extends Node2D

@export var enable = false
@export var tilemap: InfiniteMap

@onready var tile_size = tilemap.tile_set.tile_size

var current = null
var curr_tile = null

func _process(delta):
	if enable:
		if current != tilemap._current_center_offset or curr_tile != tilemap.tile_pos:
			queue_redraw()

func _draw():
	if not enable: return
	
	draw_circle(tilemap.map_to_local(tilemap.tile_center) - Vector2(tile_size / 2), 5, Color.RED)
	
	if tilemap.tile_pos != null:
		draw_circle(tilemap.map_to_local(tilemap.tile_pos), 5, Color.DARK_GREEN)
		curr_tile = tilemap.tile_pos
		
		
	if tilemap.grid_pos != null:
		draw_circle(_grid_to_local(tilemap.grid_pos, true), 5, Color.CYAN)
#		_draw_rect(tilemap.grid_pos, Color(0, 0, 1, 0.5))
		print("%s -> %s" % [tilemap.tile_pos, tilemap.grid_pos])

		if tilemap.grid_dir != null:
			_draw_dir(tilemap.grid_pos, tilemap.grid_dir, Color.DARK_GREEN)
	
	_draw_rect(tilemap._current_center_offset, Color(0.5, 0.5, 0, 0.5))
	current = tilemap._current_center_offset

#
#	_draw_rect(tilemap.grid_pos, Color(1, 0, 0, 0.5))

func _draw_rect(grid_pos: Vector2i, color: Color):
	var start = _grid_to_local(grid_pos)
	var rect = Rect2(start, tilemap.tile_size_on_grid * tile_size)
	draw_rect(rect, color)

func _draw_dir(grid_pos: Vector2i, grid_dir: Vector2i, color: Color):
	var start = _grid_to_local(grid_pos, true)
	var end = _grid_to_local(grid_pos - grid_dir, true)
	draw_line(start, end, color, 5)

func _grid_to_local(grid: Vector2i, center = false):
	var tile = tilemap._grid_to_tile(grid)
	if center:
		tile += tilemap.tile_size_on_grid / 2
	return tilemap.map_to_local(tile) - Vector2(tile_size / 2)
