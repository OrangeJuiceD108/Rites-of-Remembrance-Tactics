class_name Wait extends Action

func _init():
	type = Type.WAIT
	action_name = "Wait"

func is_available() -> bool:
	return true

func action_selected():
	controller.confirm_move()
	controller.change_state(Player_Turn_State.State.IDLE, {})
	%"UI Manager".change_state(UI_State.State.IDLE, {})
