class_name UI_Manager extends Control

@onready var action_menu = $"Action Menu"

signal action_chosen(action: Constants.ActionFlags)

func _ready():
	action_menu.action_chosen.connect(_on_action_chosen)

func show_actions_menu(actions: int, cell: Vector2):
	var world_position = GameState.grid.get_loc_by_cell(cell)
	
	# FIXME: There needs to be some logic here to make the offset, 
	#        in cases where its close to the edge of the screen
	var menu_offset = Vector2(16, 0)
	action_menu.position = world_position + menu_offset
	action_menu.build(actions)
	action_menu.visible = true

func hide_action_menu():
	action_menu.visible = false

func _on_action_chosen(action: Constants.ActionFlags):
	action_chosen.emit(action)
