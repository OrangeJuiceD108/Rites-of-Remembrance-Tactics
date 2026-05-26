class_name Unit_Manager extends Node

var occupied_tiles: Array[Vector2i]

@onready var enemy_manager = get_node("Enemy Unit Manager") as Enemy_Unit_Manager
@onready var player_manager = get_node("Player Unit Manager") as Player_Unit_Manager
@onready var ally_manager = get_node_or_null("Allied Unit Manager") as Allied_Unit_Manger

# TODO: I'll need more states at some point I'm sure
enum State {IDLE, UNIT_SELECTED, UNIT_MOVING, ACTION_SELECTED} 
var state = State.IDLE

func _ready():
	var cursor = $"../Cursor"
	cursor.cell_clicked.connect(_on_cell_clicked)
	var ui_manager = $"../UI Manager"
	ui_manager.action_menu.action_chosen.connect(_on_action_chosen)

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

# TODO: finish _handle_unit_selected_click
func _handle_unit_selected_click(cell: Vector2i):
	# TODO: Cell w/ unit logic
	# Basically builds the menu that should come up, along with temporarily moving the unit
	# Cases that we need to handle here:
	#  - Spot is empty and within move range (Wait/Items); NOTE: State -> UNIT_MOVING
	#    - and has enemy within attack range (Attack)
	#    - and has speakable character within speaking range (Talk)
	#    - and has player within interaction range (Trade/Rescue)
	#    - and has player within spell range (Heal/Teleport)
	#  - (NOTE: This can be implemented later) Spot is not empty, but spot meets one of the following conditions: 
	#    - Spot has enemy and is within attack range of a reachable empty spot (Open Attack Menu; State -> ACTION_SELECTED, Auto Select Target)
	#    - Spot has speakable character and is within speaking range of another reachable spot (Open Actions Menu, Highlight Talk; State -> UNIT_MOVING)
	#    - Spot has player and is within interaction range of another reachable spot (Open Actions Menu, Highlight Trade; STATE -> UNIT_MOVING)
	#    - Spot has player and is within heal range of another reachable spot (Open Heal Menu; State -> ACTION_SELECTED, Auto Select Target)
	#  - Spot fails all above conditions (Ignore Event or Deselect)
	# This would be a really great spot for one of those number enums, 
	# so that each of these menu buttons can just be an integer that we add to a number
	# Possible setup:
	# - 128 = Talk
	# - 64  = Attack
	# - 32  = Heal
	# - 16  = Teleport
	# - 8   = Rescue
	# - 4   = Trade
	# - 2   = Items
	# - 1   = Wait
	pass

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
