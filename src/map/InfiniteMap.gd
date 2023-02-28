extends TileMap

@export var layer := 0
@export var grid_dividor := 3

@onready var tile_size_on_grid = _calc_tile_size_on_grid()

var _grid_center = Vector2i.ZERO

func _ready():
    print("Grid Size: %s" % tile_size_on_grid)

    update_for_position(tile_size_on_grid / 2)
    update_for_position(tile_size_on_grid)


func _calc_tile_size_on_grid():
    var rect = get_used_rect()
    return rect.size / grid_dividor


func update_for_position(position: Vector2):
    var tile_pos = local_to_map(position)
    var grid_pos = _tile_to_grid(tile_pos)

    print("Tile Position %s in grid: %s" % [tile_pos, grid_pos])

    var grid_dir = grid_pos - _grid_center
    print("Grid Direction: %s" % grid_dir)

    var is_outside_grid = grid_dir.length() > 0

    if is_outside_grid:
        print("Position outside of grid. Moving tiles")

        for neighbor_dir in _get_grid_dirs_to_fill(grid_dir):
            var target_grid = grid_pos + neighbor_dir
            var opposite_neighbor_dir = Vector2i(neighbor_dir.x % grid_dividor, neighbor_dir.y % grid_dividor)
            print("Neighbor %s - Opposite %s" % [neighbor_dir, opposite_neighbor_dir])

            var source_grid = grid_pos + opposite_neighbor_dir
            print("Cutting tiles from %s to %s" % [source_grid, target_grid])
            _cut_grid_tiles(source_grid, target_grid)

        _grid_center = grid_pos
        print("New origin offset: %s" % offset)


func _get_grid_dirs_to_fill(grid_dir: Vector2i):
    var neighbors = [
        Vector2i.LEFT,
        Vector2i.RIGHT,
        Vector2i.UP,
        Vector2i.DOWN,
        Vector2i(1, 1),
        Vector2i(-1, -1),
        Vector2i(1, -1),
        Vector2i(-1, 1),
    ]

    var result = []
    for n in neighbors:
        var dot = grid_dir.dot(n)
        var is_straight = rad_to_deg(grid_dir.angle()) % 90 == 0

        if dot > 0 or (not is_straight and dot == 0):
            result.append(n)

    return result


func _cut_grid_tiles(source_grid: Vector2i, target_grid: Vector2i):
    var source_top_left = _grid_to_tile(source_grid)
    var target_top_left = _grid_to_tile(target_grid)

    for x in range(0, tile_size_on_grid.x):
        for y in range(0, tile_size_on_grid.y):
            var offset = Vector2i(x, y)
            var source_cell = source_top_left + offset
            var target_cell = target_top_left + offset

            var source_id = get_cell_source_id(layer, source_cell)
            set_cell(layer, target_cell, source_id)


func _grid_to_tile(grid_pos: Vector2i):
    return Vector2i(tile_size_on_grid.x * grid_pos.x, tile_size_on_grid.y * grid_pos.y)


func _tile_to_grid(tile_pos: Vector2i):
    return tile_pos.snapped(tile_size_on_grid) / tile_size_on_grid