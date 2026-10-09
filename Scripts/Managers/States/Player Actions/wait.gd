class_name Wait extends Action

func _init():
	type = Type.WAIT
	action_name = "Wait"

func is_available(_unit: Unit, _cell: Vector2i) -> bool:
	return true

func action_selected():
	player_manager.confirm_move()
	state = State.IDLE
	ui_manager.change_state(UI_State.State.IDLE, {})

func confirm(_kwargs: Array):
	pass

func cancel():
	pass
