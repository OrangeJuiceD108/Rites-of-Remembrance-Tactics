class_name Player_Unit extends Unit

var staged_location : Vector2i

func _ready():
	super._ready()
	staged_location = grid_position

func stage_move(cell: Vector2i):
	staged_location = cell
	var displacement = GameState.grid.get_loc_by_cell(cell) - position
	sprite.position = displacement

func confirm_move():
	sprite.position = Vector2.ZERO
	change_position(staged_location)
