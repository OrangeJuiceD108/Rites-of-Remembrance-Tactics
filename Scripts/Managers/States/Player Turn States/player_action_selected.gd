class_name Player_Action_Selected extends Player_Turn_State

func _init():
	state = State.ACTION_SELECTED

func enter(_kwargs: Dictionary):
	pass

func cell_clicked(_cell: Vector2i):
	pass

func exit():
	pass
