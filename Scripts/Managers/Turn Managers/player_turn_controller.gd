class_name Player_Turn_Controller extends Turn_Controller

var actions : Dictionary[Action.Type, Action]
var states : Dictionary[Player_Turn_State.State, Player_Turn_State]
var current_state : Player_Turn_State

var selected_unit : Unit

var move_cells : Array[Vector2i]
var attack_cells : Array[Vector2i]
var staged_attack_cells : Array[Vector2i]

@onready var tile_highlighter : Tile_Highlighter = $"Tile Highlighter"

signal unit_selected(targeting_cells: Array[Vector2i])
signal unit_deselected()

func _ready():
	for child in $"Actions".get_children():
		actions[child.type] = child
		child.controller = self
	
	for child in $"States".get_children():
		child.faction = faction
		child.controller = self
		states[child.state] = child
	current_state = states[Player_Turn_State.State.IDLE]
	
	%"Cursor".moved.connect(_on_cursor_moved)
	%"Cursor".cell_clicked.connect(_on_cell_clicked)

func _on_cursor_moved(cell: Vector2i):
	%"UI Manager".state.update_target_cell(cell)

func _on_cell_clicked(cell: Vector2i):
	current_state.cell_clicked(cell)

func change_state(new_state: Player_Turn_State.State, kwargs: Dictionary):
	current_state.exit()
	current_state = states[new_state]
	current_state.enter(kwargs)

func select_unit(unit: Unit):
	selected_unit = unit
	move_cells = unit.get_move_radius()
	attack_cells = unit.get_attack_radius(move_cells)
	unit_selected.emit(move_cells + attack_cells)
	tile_highlighter.populate_ranges(move_cells, attack_cells)

func deselect_unit():
	selected_unit = null
	tile_highlighter.clear_staged_attack()
	tile_highlighter.clear_ranges()
	unit_deselected.emit()

func stage_unit(cell: Vector2i, a_cells: Array[Vector2i]):
	selected_unit.stage_move(cell)
	tile_highlighter.hide_ranges()
	staged_attack_cells = a_cells
	tile_highlighter.populate_staged_attack(a_cells)

func confirm_move():
	selected_unit.confirm_move()
	deselect_unit()
