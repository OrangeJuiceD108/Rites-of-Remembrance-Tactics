class_name Player_Unit_Manager extends Node

@export var move_cell_sprite : Texture2D
@export var attack_cell_sprite : Texture2D

var player_units: Array[Player_Unit]

var selected_unit: Player_Unit

var move_cells: Array[Vector2i]
var attack_cells: Array[Vector2i]

var cell_sprite_container : Node2D

signal unit_selected(targeting_cells: Array[Vector2i])
signal unit_deselected()

func _ready() -> void:
	for child in get_children():
		if child is Player_Unit:
			player_units.append(child)

func get_unit_at_cell(cell: Vector2i) -> Player_Unit:
	for unit in player_units:
		if unit.grid_position == cell:
			return unit
	return null

func select_unit(unit: Player_Unit):
	selected_unit = unit
	move_cells = unit.get_move_radius()
	attack_cells = unit.get_attack_radius(move_cells)
	unit_selected.emit(move_cells + attack_cells)
	_populate_ranges(move_cells, attack_cells)

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
