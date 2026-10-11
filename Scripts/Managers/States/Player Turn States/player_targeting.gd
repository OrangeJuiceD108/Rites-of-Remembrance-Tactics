class_name Player_Targeting extends Player_Turn_State

func _init():
	state = State.TARGETING

func enter(_kwargs: Dictionary):
	controller.selected_action.on_targeting()
	%"Cursor".lock(controller.selected_action.get_targetable_cells())

func cell_clicked(cell: Vector2i):
	controller.selected_action.confirm_cell(cell)

func exit():
	%"Cursor".unlock()
