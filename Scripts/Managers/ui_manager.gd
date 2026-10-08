class_name UI_Manager extends Control

@onready var action_menu : Action_Menu = $"Action Menu"
@onready var inventory_menu : Inventory_Menu = $"Inventory Menu"
@onready var unit_summary : Unit_Summary = $"Unit Summary"
@onready var unit_quick_info : Unit_Quick_Info = $"Unit Quick Info"
@onready var battle_summary : Battle_Summary = $"Battle Summary"

signal action_chosen(action: Constants.ActionFlags)
signal weapon_chosen()

var state : UI_State
var states : Dictionary[UI_State.State, UI_State]

func _enter_tree():
	size = get_viewport_rect().size

func _ready():
	for child in $"States".get_children():
		states[child.state] = child
	state = states[UI_State.State.IDLE]
	
	action_menu.action_chosen.connect(_on_action_chosen)
	inventory_menu.weapon_chosen.connect(_on_weapon_chosen)

func change_state(new_state: UI_State.State, kwargs: Dictionary):
	state.exit()
	state = states[new_state]
	state.enter(kwargs)

func _on_action_chosen(action: Constants.ActionFlags):
	#hide_action_menu()
	action_chosen.emit(action)

func _on_weapon_chosen():
	#hide_weapons_menu()
	weapon_chosen.emit()
