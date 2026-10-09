class_name Player_Unit_Selected extends Player_Turn_State

func _init():
	state = State.UNIT_SELECTED

func enter(kwargs: Dictionary):
	var unit : Unit = kwargs["unit"]
	controller.select_unit(unit)

func cell_clicked(cell: Vector2i):
	if cell == controller.selected_unit.grid_position:
		var kwargs = {"cell": cell}
		controller.change_state(State.UNIT_STAGED, kwargs)
	elif controller.move_cells.has(cell) && !%"Unit Manager".occupied_tiles.has(cell):
		var kwargs = {"cell": cell}
		controller.change_state(State.UNIT_STAGED, kwargs)
	elif %"Unit Manager".occupied_tiles.has(cell) and controller.attack_cells.has(cell):
		_occupied_cell_clicked(cell)
	else:
		push_error("Out of move range")

func exit():
	pass

func _empty_cell_clicked(cell: Vector2i):
	pass

func _occupied_cell_clicked(cell: Vector2i):
	push_error("Unimplemented")
