class_name UI_Manager extends Control

signal item_chosen(item: Item, inventory: Inventory)
signal item_hovered(item: Item, inventory: Inventory)

var state : UI_State
var states : Dictionary[UI_State.State, UI_State]

func _enter_tree():
	size = get_viewport_rect().size

func _ready():
	for child in $"States".get_children():
		states[child.state] = child
	state = states[UI_State.State.IDLE]
	
	$"Inventory Menu".item_chosen.connect(_on_item_chosen)
	$"Inventory Menu".item_hovered.connect(_on_item_hovered)

func change_state(new_state: UI_State.State, kwargs: Dictionary):
	state.exit()
	state = states[new_state]
	state.enter(kwargs)

func _on_item_chosen(item: Item, inventory: Inventory):
	item_chosen.emit(item, inventory)

func _on_item_hovered(item: Item, inventory: Inventory):
	item_hovered.emit(item, inventory)
