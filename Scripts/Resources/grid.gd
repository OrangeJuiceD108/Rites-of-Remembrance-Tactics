class_name Grid extends Resource

@export var size := Vector2(20,20)
@export var cell_size := Vector2(16, 16)

# TODO: STORE MAP

func get_cell(loc: Vector2) -> Vector2:
	return (loc/cell_size).floor()


# Should check when a given position (not tile) is within grid bounds
func is_within_bounds(loc: Vector2) -> bool:
	return 0 < loc.x and loc.x < cell_size.x * size.x and 0 < loc.y and loc.y < cell_size.y * size.y


# Should return a given grid position as clamped within grid bounds
func clamp(grid_loc: Vector2) -> Vector2:
	var out := grid_loc
	out.x = clamp(out.x, 0, size.x - 1.0)
	out.y = clamp(out.y, 0, size.y - 1.0)
	return out


# Should return a given grid positon as an index to a 1D array
func as_index(grid_loc: Vector2) -> int:
	return int(grid_loc.x + grid_loc.y * size.x)
