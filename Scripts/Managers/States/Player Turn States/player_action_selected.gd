class_name Player_Action_Selected extends Player_Turn_State

var selected_action : Action

func _init():
	state = State.ACTION_SELECTED

func enter(kwargs: Dictionary):
	selected_action = kwargs["action"]

func cell_clicked(cell: Vector2i):
	selected_action.confirm_cell(cell)

func exit():
	selected_action = null
