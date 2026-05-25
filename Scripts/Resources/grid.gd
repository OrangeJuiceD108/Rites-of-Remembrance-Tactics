class_name Grid extends Resource

@export var size := Vector2i(20,20)
@export var cell_size := Vector2i(16, 16)

# TODO: STORE MAP

# Takes world position (float) and returns grid position (integer)
func get_cell(loc: Vector2) -> Vector2i:
	return grid_clamp(Vector2i((loc / Vector2(cell_size)).floor()))


func get_loc_by_cell(cell: Vector2i) -> Vector2:
	return Vector2(cell * cell_size) + Vector2(cell_size) / 2.0


func snap_to_cell(cell: Vector2i) -> Vector2:
	return get_loc_by_cell(cell)


# Should check when a given position (not tile) is within grid bounds
func is_within_bounds(loc: Vector2) -> bool:
	return 0 < loc.x and loc.x < cell_size.x * size.x and 0 < loc.y and loc.y < cell_size.y * size.y


# Should return a given grid position as clamped within grid bounds
func grid_clamp(grid_loc: Vector2i) -> Vector2i:
	return Vector2i(
		clamp(grid_loc.x, 0, size.x - 1),
		clamp(grid_loc.y, 0, size.y - 1)
	)

# Should return a given grid positon as an index to a 1D array
func as_index(grid_loc: Vector2i) -> int:
	return grid_loc.x + grid_loc.y * size.x
