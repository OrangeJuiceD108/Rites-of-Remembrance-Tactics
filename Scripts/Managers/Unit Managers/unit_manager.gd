class_name Unit_Manager extends Node

var occupied_tiles : Array[Vector2i]:
	get: 
		return player_manager.occupied_tiles + enemy_manager.occupied_tiles + ally_manager.occupied_tiles

@onready var enemy_manager = get_node("Enemy Unit Manager") as Enemy_Unit_Manager
@onready var player_manager = get_node("Player Unit Manager") as Player_Unit_Manager
@onready var ally_manager = get_node("Allied Unit Manager") as Allied_Unit_Manger

@onready var ui_manager = $"../UI Manager"

# TODO: I'll need more states at some point I'm sure
enum State {IDLE, UNIT_SELECTED, UNIT_STAGED, ACTION_SELECTED} 
var state = State.IDLE

func _ready():
	var cursor = $"../Cursor"
	cursor.cell_clicked.connect(_on_cell_clicked)
	
	ui_manager = $"../UI Manager"
	ui_manager.action_chosen.connect(_on_action_chosen)

# TODO: Implement _on_cell_clicked
func _on_cell_clicked(cell: Vector2i):
	match state: 
		State.IDLE:
			_handle_idle_click(cell)
		State.UNIT_SELECTED:
			_handle_unit_selected_click(cell)
	pass

func _handle_idle_click(cell: Vector2i):
	var unit = player_manager.get_unit_at_cell(cell)
	if unit:
		state = State.UNIT_SELECTED
		player_manager.select_unit(unit)
	else:
		# TODO: This should try to get a unit here for enemy, then ally. If neither work, should bring up the menu I think
		pass
	pass

func _handle_unit_selected_click(cell: Vector2i):
	if cell == player_manager.selected_unit.grid_position:
		_handle_empty_cell_click(cell)
	elif !occupied_tiles.has(cell) and player_manager.move_cells.has(cell):
		_handle_empty_cell_click(cell)
	elif occupied_tiles.has(cell) and player_manager.attack_cells.has(cell):
		_handle_occupied_cell_click(cell)
	else: 
		push_error("Out of move range somehow")

func _handle_empty_cell_click(cell: Vector2i):
	state = State.UNIT_STAGED
	var selected_unit = player_manager.selected_unit
	
	var a_cells = selected_unit.get_attack_radius([cell] as Array[Vector2i])
	player_manager.stage_unit(cell, a_cells)
	
	var actions = Constants.ActionFlags.WAIT | Constants.ActionFlags.ITEMS
	for a_cell in a_cells: 
		if enemy_manager.occupied_tiles.has(a_cell):
			actions |= Constants.ActionFlags.ATTACK
			break
	
	# TODO: Check for speakable units here!
	
	var directions = [Vector2i(0,1), Vector2i(0,-1), Vector2i(1,0), Vector2i(-1,0)]
	for dir in directions:
		if player_manager.occupied_tiles.has(cell + dir):
			actions |= Constants.ActionFlags.TRADE
			# TODO: Check to see if unit has rescue here!
	
	# TODO: Check to see if unit has heal here!
	# TODO: Check to see if unit has other spell here!
	
	ui_manager.show_actions_menu(actions, cell)

func _handle_occupied_cell_click(cell: Vector2i):
	# Handles case that spot is not empty, but spot meets one of the following conditions: 
	#  - Spot has enemy and is within attack range of a reachable empty spot (Open Attack Menu; State -> ACTION_SELECTED, Auto Select Target)
	#  - Spot has speakable character and is within speaking range of another reachable spot (Open Actions Menu, Highlight Talk; State -> UNIT_MOVING)
	#  - Spot has player and is within interaction range of another reachable spot (Open Actions Menu, Highlight Trade; STATE -> UNIT_MOVING)
	#  - Spot has player and is within heal range of another reachable spot (Open Heal Menu; State -> ACTION_SELECTED, Auto Select Target)
	#  - Spot fails all above conditions (Ignore Event or Deselect)
	# Or case that spot is not empty and fails all above conditions (Ignore Event or Deselect)
	push_error("Not Implemented")

# TODO: finish _on_action_chosen
func _on_action_chosen(action: Constants.ActionFlags):
	match action:
		Constants.ActionFlags.TALK:
			pass
		Constants.ActionFlags.ATTACK:
			pass
		Constants.ActionFlags.HEAL:
			pass
		Constants.ActionFlags.TELEPORT:
			pass
		Constants.ActionFlags.RESCUE:
			pass
		Constants.ActionFlags.TRADE:
			pass
		Constants.ActionFlags.ITEMS:
			pass
		Constants.ActionFlags.WAIT:
			pass
