class_name State_Actions_Menu extends UI_State

@onready var action_menu : Action_Menu = %"UI Manager/Action Menu"

func _init():
	state = State.ACTIONS_MENU

func enter(kwargs: Dictionary):
	var actions : Array[Action] = kwargs["actions"]
	var cell : Vector2i = kwargs["cell"]
	action_menu.show_element(actions, cell)

func exit():
	action_menu.hide_element()
