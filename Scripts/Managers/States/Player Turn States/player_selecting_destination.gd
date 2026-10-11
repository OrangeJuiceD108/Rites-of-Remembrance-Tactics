class_name Player_Selecting_Destination extends Player_Turn_State

func _init():
	state = State.SELECTING_DESTINATION

func enter(kwargs: Dictionary):
	%"UI Manager".change_state(UI_State.State.IDLE, {}) #redundant?
	var unit : Unit = kwargs["unit"]
	controller.select_unit(unit)

func cell_clicked(cell: Vector2i):
	if cell == controller.selected_unit.grid_position:
		var kwargs = {"cell": cell}
		controller.change_state(State.SELECTING_ACTION, kwargs)
	elif controller.move_cells.has(cell) && !%"Unit Manager".occupied_tiles.has(cell):
		var kwargs = {"cell": cell}
		controller.change_state(State.SELECTING_ACTION, kwargs)
	elif %"Unit Manager".occupied_tiles.has(cell) and controller.attack_cells.has(cell):
		_occupied_cell_clicked(cell)
	else:
		push_error("Out of move range")

func exit():
	pass

func _occupied_cell_clicked(cell: Vector2i):
	push_error("Unimplemented")
