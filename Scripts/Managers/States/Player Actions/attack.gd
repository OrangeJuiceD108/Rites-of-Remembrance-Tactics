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

func get_targetable_cells():
	var cells : Array[Vector2i]
	for cell in controller.staged_attack_cells:
		var unit = %"Unit Manager".get_unit_at_cell(cell)
		if unit != null && %"Unit Manager".are_hostile(controller.selected_unit, unit):
			cells.append(cell)
	return cells

func action_selected():
	var kwargs = {"unit": controller.selected_unit}
	controller.selected_action = self
	%"UI Manager".weapon_chosen.connect(_weapon_selected, CONNECT_ONE_SHOT)
	%"UI Manager".change_state(UI_State.State.WEAPONS_MENU, kwargs)

func _weapon_selected():
	controller.change_state(Player_Turn_State.State.TARGETING, {})

func on_targeting():
	var kwargs = {"player": controller.selected_unit}
	%"UI Manager".change_state(UI_State.State.BATTLE_PREVIEW, kwargs)

func confirm_cell(cell: Vector2i):
	var target = %"Unit Manager".get_unit_at_cell(cell)
	if target == null || !%"Unit Manager".enemy_registry.are_hostile(controller.faction, target.faction):
		push_error("Impossible target")
	
	Battle_Simulator.run_battle(controller.selected_unit, target)
	%"UI Manager".change_state(UI_State.State.IDLE, {})
	
	controller.confirm_move()
	controller.selected_action = null
	controller.change_state(Player_Turn_State.State.IDLE, {})
	# TODO: Exhaust unit

func cancel():
	controller.selected_action = null
	# FIXME: Other stuff to cancel an action
	# - Will need to disconnect that _weapon_selected signal in the case that it is cancelled then.
