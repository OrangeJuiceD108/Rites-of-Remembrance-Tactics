class_name Player_Unit_Manager extends Node

@export var move_cell_sprite : Texture2D
@export var attack_cell_sprite : Texture2D

var player_units: Array[Player_Unit]

var selected_unit: Player_Unit

var move_cells: Array[Vector2i]
var attack_cells: Array[Vector2i]

var cell_sprites: Array[Sprite2D]

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
	_display_ranges(move_cells, attack_cells)

func _display_ranges(m_cells: Array[Vector2i], a_cells: Array[Vector2i]):
	for cell in m_cells:
		var sprite = Sprite2D.new()
		sprite.texture = move_cell_sprite
		sprite.position = GameState.grid.get_loc_by_cell(cell)
		cell_sprites.append(sprite)
		add_child(sprite)
	a_cells = a_cells.filter(func(item): return not m_cells.has(item))
	for cell in a_cells:
		var sprite = Sprite2D.new()
		sprite.texture = attack_cell_sprite
		sprite.position = GameState.grid.get_loc_by_cell(cell)
		cell_sprites.append(sprite)
		add_child(sprite)
