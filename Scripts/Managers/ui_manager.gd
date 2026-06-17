class_name UI_Manager extends Control

@onready var action_menu = $"Action Menu"
@onready var inventory_menu = $"Inventory Menu"
@onready var unit_summary = $"Unit Summary"
@onready var unit_quick_info = $"Unit Quick Info"

signal action_chosen(action: Constants.ActionFlags)
signal weapon_chosen()

func _enter_tree():
	size = get_viewport_rect().size

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
	action_menu.visible = true

func hide_action_menu():
	$"../Cursor".enable_cursor()
	action_menu.visible = false

func show_weapons_menu(unit: Unit):
	unit_summary.build_summary(unit)
	inventory_menu.build_attack(unit.inventory)
	$"../Cursor".disable_cursor()
	unit_summary.visible = true
	inventory_menu.visible = true

func hide_weapons_menu():
	$"../Cursor".enable_cursor()
	unit_summary.visible = false
	inventory_menu.visible = false

func show_unit_quick_info(unit: Unit):
	var direction : Vector2i
	
	var cursor_position = get_viewport().get_mouse_position()
	var viewport_size = get_viewport_rect().size
	
	if cursor_position.x / viewport_size.x < 0.5 && cursor_position.y / viewport_size.y < 0.5:
		direction = Vector2i.DOWN
	else:
		direction = Vector2i.UP
	
	unit_quick_info.shift_corner(direction)
	unit_quick_info.update_unit(unit)
	unit_quick_info.visible = true

func hide_unit_quick_info():
	unit_quick_info.visible = false

func _on_action_chosen(action: Constants.ActionFlags):
	hide_action_menu()
	action_chosen.emit(action)

func _on_weapon_chosen():
	hide_weapons_menu()
	weapon_chosen.emit()
