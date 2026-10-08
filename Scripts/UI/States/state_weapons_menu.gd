class_name State_Weapons_Menu extends UI_State

@onready var inventory_menu : Inventory_Menu = %"UI Manager/Inventory Menu"
@onready var unit_summary : Unit_Summary = %"UI Manager/Unit Summary"

func _init():
	state = State.WEAPONS_MENU

func enter(kwargs: Dictionary):
	var unit : Unit = kwargs["unit"]
	
	unit_summary.show_element(unit)
	inventory_menu.show_element(unit, true)

func exit():
	unit_summary.hide_element()
	inventory_menu.hide_element()
