class_name UI_Manager extends Node

@onready var grid = $"../Map Manager".grid
@onready var action_menu = $"Action Menu"

func show_actions_menu(actions: int, cell: Vector2):
	var world_position = grid.get_loc_by_cell(cell)
	
	var menu_offset = Vector2(16, 0)
	action_menu.position = world_position + menu_offset
	action_menu.build(actions)
	action_menu.visible = true

func hide_action_menu():
	action_menu.visible = false
