class_name State_UI_Idle extends UI_State

@onready var unit_quick_info : Unit_Quick_Info = %"UI Manager/Unit Quick Info"

func _init():
	state = State.IDLE

func enter(_kwargs: Dictionary):
	update_target_cell(%"Cursor".cursor_cell)

func exit():
	unit_quick_info.hide_element()

func update_target_cell(_cell: Vector2i):
	var unit =  %"Unit Manager".get_unit_at_cell(_cell)
	if unit == null:
		unit_quick_info.hide_element()
	else:
		unit_quick_info.show_element(unit)
