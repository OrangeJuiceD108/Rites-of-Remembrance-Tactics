class_name UI_Manager extends Control

@onready var action_menu = $"Action Menu"
@onready var inventory_menu = $"Inventory Menu"

signal action_chosen(action: Constants.ActionFlags)
signal weapon_chosen()

func _ready():
	action_menu.action_chosen.connect(_on_action_chosen)
	inventory_menu.weapon_chosen.connect(_on_weapon_chosen)

func show_actions_menu(actions: int, cell: Vector2):
	var world_position = GameState.grid.get_loc_by_cell(cell)
	
	# FIXME: There needs to be some logic here to make the offset, 
	#        in cases where its close to the edge of the screen
	# FIXME: This should actually be in the menu class, so that it matches the rest
	var menu_offset = Vector2(16, 0)
	action_menu.position = world_position + menu_offset
	action_menu.build(actions)
	$"../Cursor".disable_cursor()
	print("cursor disable - actions")
	action_menu.visible = true

func hide_action_menu():
	$"../Cursor".enable_cursor()
	print("cursor enable - actions")
	action_menu.visible = false

func show_weapons_menu(inventory: Inventory):
	inventory_menu.build_attack(inventory)
	$"../Cursor".disable_cursor()
	print("cursor disable - weapons")
	inventory_menu.visible = true

func hide_weapons_menu():
	$"../Cursor".enable_cursor()
	print("cursor enable - weapons")
	inventory_menu.visible = false

func _on_action_chosen(action: Constants.ActionFlags):
	hide_action_menu()
	action_chosen.emit(action)

func _on_weapon_chosen():
	hide_weapons_menu()
	weapon_chosen.emit()
