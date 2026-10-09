class_name Attack extends Action

func _init():
	type = Type.ATTACK
	action_name = "Attack"

func is_available(unit: Unit, cell: Vector2i) -> bool:
	pass

func action_selected():
	var kwargs = {"unit": player_manager.selected_unit}
	ui_manager.change_state(UI_State.State.WEAPONS_MENU, kwargs)

func confirm(_kwargs: Array):
	pass

func cancel():
	pass
