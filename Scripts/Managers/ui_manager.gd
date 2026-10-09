class_name UI_Manager extends Control

signal weapon_chosen()

var state : UI_State
var states : Dictionary[UI_State.State, UI_State]

func _enter_tree():
	size = get_viewport_rect().size

func _ready():
	for child in $"States".get_children():
		states[child.state] = child
	state = states[UI_State.State.IDLE]
	
	$"Inventory Menu".weapon_chosen.connect(_on_weapon_chosen)

func change_state(new_state: UI_State.State, kwargs: Dictionary):
	state.exit()
	state = states[new_state]
	state.enter(kwargs)

func _on_weapon_chosen():
	weapon_chosen.emit()
