class_name Unit_Manager extends Node

var occupied_tiles : Array[Vector2i]:
	get: 
		return player_manager.occupied_tiles + enemy_manager.occupied_tiles + ally_manager.occupied_tiles

@onready var enemy_manager : Enemy_Unit_Manager = $"Enemy Unit Manager"
@onready var player_manager : Player_Unit_Manager = $"Player Unit Manager"
@onready var ally_manager : Allied_Unit_Manger = $"Allied Unit Manager"

@onready var ui_manager : UI_Manager = $"../UI Manager"
@onready var cursor : Cursor = $"../Cursor"

# TODO: I'll need more states at some point I'm sure
enum State {IDLE, UNIT_SELECTED, UNIT_STAGED, ACTION_SELECTED} 
var state = State.IDLE
var current_action = Constants.ActionFlags.NONE

func _ready():
	cursor.cell_clicked.connect(_on_cell_clicked)
	ui_manager.action_chosen.connect(_on_action_chosen)

# TODO: Implement _on_cell_clicked
func _on_cell_clicked(cell: Vector2i):
	match state: 
		State.IDLE:
			_handle_idle_click(cell)
		State.UNIT_SELECTED:
			_handle_unit_selected_click(cell)
		State.ACTION_SELECTED:
			_handle_action_selected(cell)
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

func _handle_action_selected(cell: Vector2i):
	match current_action:
		Constants.ActionFlags.TALK:
			_handle_action_talk(cell)
		Constants.ActionFlags.ATTACK:
			_handle_action_attack(cell)
		Constants.ActionFlags.HEAL:
			_handle_action_heal(cell)
		Constants.ActionFlags.TELEPORT:
			_handle_action_teleport(cell)
		Constants.ActionFlags.RESCUE:
			_handle_action_rescue(cell)
		Constants.ActionFlags.TRADE:
			_handle_action_trade(cell)
		_:
			push_error("current_action mismatch error")

# TODO: finish handle_action_talk
func _handle_action_talk(cell: Vector2i):
	pass

# TODO: finish handle_action_attack
func _handle_action_attack(cell: Vector2i):
	# TODO: Run the attack
	print("Got his ass!") #FIXME Temporary debug statement
	
	player_manager.confirm_move()
	state = State.IDLE
	current_action = Constants.ActionFlags.NONE
	# TODO: Exhaust unit

# TODO: finish handle_action_heal
func _handle_action_heal(cell: Vector2i):
	pass

# TODO: finish handle_action_teleport
func _handle_action_teleport(cell: Vector2i):
	pass

# TODO: finish handle_action_rescue
func _handle_action_rescue(cell: Vector2i):
	pass

# TODO: finish handle_action_trade
func _handle_action_trade(cell: Vector2i):
	pass

func _on_action_chosen(action: Constants.ActionFlags):
	match action:
		Constants.ActionFlags.TALK:
			_action_talk()
		Constants.ActionFlags.ATTACK:
			_action_attack()
		Constants.ActionFlags.HEAL:
			_action_heal()
		Constants.ActionFlags.TELEPORT:
			_action_teleport()
		Constants.ActionFlags.RESCUE:
			_action_rescue()
		Constants.ActionFlags.TRADE:
			_action_teleport()
		Constants.ActionFlags.ITEMS:
			_action_items()
		Constants.ActionFlags.WAIT:
			_action_wait()

# TODO: Implement _action_talk()
func _action_talk():
	pass

func _action_attack():
	# TODO: Weapon select
	
	var attackable_cells = player_manager.staged_attack_cells.filter(func(item): return enemy_manager.occupied_tiles.has(item))
	if attackable_cells.size() == 0:
		push_error("Something when wrong, 0 attackable cells")
	cursor.lock_cursor(attackable_cells)
	
	state = State.ACTION_SELECTED
	current_action = Constants.ActionFlags.ATTACK

# TODO: Implement _action_heal()
func _action_heal():
	pass

# TODO: Implement _action_teleport()
func _action_teleport():
	pass

# TODO: Implement _action_rescue()
func _action_rescue():
	pass

# TODO: Implement _action_trade()
func _action_trade():
	pass

# TODO: Implement _action_items()
func _action_items():
	pass

func _action_wait():
	player_manager.confirm_move()
	state = State.IDLE
