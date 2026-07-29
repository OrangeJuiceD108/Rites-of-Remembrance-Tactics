class_name Player_Unit_Manager extends Node

@export var move_cell_sprite : Texture2D
@export var attack_cell_sprite : Texture2D

var units : Array[Player_Unit]
var occupied_tiles : Array[Vector2i]:
	get:
		var tiles : Array[Vector2i]
		for unit in units:
			tiles.append(unit.grid_position)
		return tiles

var selected_unit : Player_Unit

var move_cells : Array[Vector2i]
var attack_cells : Array[Vector2i]
var staged_attack_cells : Array[Vector2i]

var cell_sprite_container : Node2D
var staged_attack_radius : Node2D

signal unit_selected(targeting_cells: Array[Vector2i])
signal unit_deselected()

func _ready() -> void:
	for child in get_children():
		if child is Player_Unit:
			units.append(child)
			occupied_tiles.append(child.grid_position)

func get_unit_at_cell(cell: Vector2i):
	for unit in units:
		if unit.grid_position == cell:
			return unit
	return null

func select_unit(unit: Player_Unit):
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

func _clear_ranges():
	cell_sprite_container.queue_free()
	cell_sprite_container = null

func _display_ranges():
	cell_sprite_container.show()

func _hide_ranges():
	cell_sprite_container.hide()
