class_name Player_Idle extends Player_Turn_State

func _init():
	state = State.IDLE

func enter(_kwargs: Dictionary):
	controller.deselect_unit()

func cell_clicked(cell: Vector2i):
	var unit = %"Unit Manager".get_unit_at_cell(cell, faction)
	if unit:
		var kwargs = {"unit": unit}
		controller.change_state(State.UNIT_SELECTED, kwargs)
	else:
		# TODO: This should try to get a unit here for enemy, then ally. If neither work, should bring up the menu I think
		pass

func exit():
	pass
