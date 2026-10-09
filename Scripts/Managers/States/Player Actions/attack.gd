class_name Attack extends Action

func _init():
	type = Type.ATTACK
	action_name = "Attack"

func is_available() -> bool:
	# TODO: Check to see if the Unit has any weapons
	
	for cell in controller.staged_attack_cells:
		var unit = %"Unit Manager".get_unit_at_cell(cell)
		if unit != null && %"Unit Manager".are_hostile(controller.selected_unit, unit):
			return true
	return false

func action_selected():
	var kwargs = {"unit": controller.selected_unit}
	%"UI Manager".change_state(UI_State.State.WEAPONS_MENU, kwargs)

func confirm_cell(cell: Vector2i):
	var target = %"Unit Manager".get_unit_at_cell(cell)
	if target == null || !controller.faction.enemies.has(target.faction):
		push_error("Impossible target")
	
	Battle_Simulator.run_battle(controller.selected_unit, target)
	%"UI Manager".change_state(UI_State.State.IDLE, {})
	
	controller.confirm_move()
	controller.change_state(Player_Turn_State.State.IDLE, {})
	# TODO: Exhaust unit

func cancel():
	pass
