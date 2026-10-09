class_name Player_Unit_Staged extends Player_Turn_State

func _init():
	state = State.UNIT_STAGED

func enter(kwargs: Dictionary):
	var cell : Vector2i = kwargs["cell"]
	
	var attack_cells = controller.selected_unit.get_attack_radius([cell] as Array[Vector2i])
	controller.stage_unit(cell, attack_cells)
	
	var available_actions : Array[Action]
	for action_type in controller.actions:
		var action = controller.actions[action_type]
		if action.is_available():
			available_actions.append(action)
	var new_kwargs = {
		"actions": available_actions,
		"cell": cell
	}
	%"UI Manager".change_state(UI_State.State.ACTIONS_MENU, new_kwargs)

func exit():
	pass
