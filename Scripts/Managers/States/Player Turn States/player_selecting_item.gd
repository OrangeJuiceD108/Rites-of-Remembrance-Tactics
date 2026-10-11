class_name Player_Selecting_Item extends Player_Turn_State

func _init():
	state = State.SELECTING_ITEM

func enter(kwargs: Dictionary):
	%"UI Manager".change_state(UI_State.State.INVENTORY_MENU, kwargs)

func cell_clicked(_cell: Vector2i):
	pass

func exit():
	pass
