class_name Player_Turn_Controller extends Turn_Controller

@export var player_faction : Faction

var actions : Dictionary[Action.Type, Action]
var states : Dictionary[Player_Turn_State.State, Player_Turn_State]
var current_state : Player_Turn_State

@export var move_cell_sprite : Texture2D
@export var attack_cell_sprite : Texture2D

var selected_unit : Unit

var move_cells : Array[Vector2i]
var attack_cells : Array[Vector2i]
var staged_attack_cells : Array[Vector2i]

var cell_sprite_container : Node2D
var staged_attack_radius : Node2D

signal unit_selected(targeting_cells: Array[Vector2i])
signal unit_deselected()

func _ready():
	for child in $"Actions".get_children():
		actions[child.type] = child
	
	for child in $"States".get_children():
		child.faction = faction
		child.controller = self
		states[child.State] = child
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
	_populate_ranges(move_cells, attack_cells)

func deselect_unit():
	selected_unit = null
	_clear_staged_attack()
	_clear_ranges()
	unit_deselected.emit()

func stage_unit(cell: Vector2i, a_cells: Array[Vector2i]):
	selected_unit.stage_move(cell)
	_hide_ranges()
	staged_attack_cells = a_cells
	_populate_staged_attack(a_cells)

func confirm_move():
	selected_unit.confirm_move()
	deselect_unit()

func _populate_staged_attack(a_cells: Array[Vector2i]):
	if staged_attack_radius != null:
		push_error("Staged attack has already been populated")
	
	staged_attack_radius = Node2D.new()
	add_child(staged_attack_radius)
	
	for cell in a_cells:
		var sprite = Sprite2D.new()
		sprite.texture = attack_cell_sprite
		sprite.position = GameState.grid.get_loc_by_cell(cell)
		staged_attack_radius.add_child(sprite)

func _clear_staged_attack():
	staged_attack_radius.queue_free()
	staged_attack_radius = null

func _populate_ranges(m_cells: Array[Vector2i], a_cells: Array[Vector2i]):
	if cell_sprite_container != null:
		push_error("Ranges have already been populated")
		return
	
	cell_sprite_container = Node2D.new()
	add_child(cell_sprite_container)
	
	for cell in m_cells:
		var sprite = Sprite2D.new()
		sprite.texture = move_cell_sprite
		sprite.position = GameState.grid.get_loc_by_cell(cell)
		cell_sprite_container.add_child(sprite)
	a_cells = a_cells.filter(func(item): return not m_cells.has(item))
	for cell in a_cells:
		var sprite = Sprite2D.new()
		sprite.texture = attack_cell_sprite
		sprite.position = GameState.grid.get_loc_by_cell(cell)
		cell_sprite_container.add_child(sprite)
	_display_ranges()

func _clear_ranges():
	cell_sprite_container.queue_free()
	cell_sprite_container = null

func _display_ranges():
	cell_sprite_container.show()

func _hide_ranges():
	cell_sprite_container.hide()
