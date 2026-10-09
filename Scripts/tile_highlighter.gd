class_name Tile_Highlighter extends Node

@export var move_cell_sprite : Texture2D
@export var attack_cell_sprite : Texture2D

var cell_sprite_container : Node2D
var staged_attack_radius : Node2D

# FIXME: This can be generalized into showing and hiding by layer, with layers determining which colors have importance
# This allows me to do more I think

func populate_staged_attack(a_cells: Array[Vector2i]):
	if staged_attack_radius != null:
		push_error("Staged attack has already been populated")
	
	staged_attack_radius = Node2D.new()
	add_child(staged_attack_radius)
	
	for cell in a_cells:
		var sprite = Sprite2D.new()
		sprite.texture = attack_cell_sprite
		sprite.position = GameState.grid.get_loc_by_cell(cell)
		staged_attack_radius.add_child(sprite)

func clear_staged_attack():
	if staged_attack_radius == null: 
		return
	staged_attack_radius.queue_free()
	staged_attack_radius = null

func populate_ranges(m_cells: Array[Vector2i], a_cells: Array[Vector2i]):
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
	display_ranges()

func clear_ranges():
	if cell_sprite_container == null:
		return
	cell_sprite_container.queue_free()
	cell_sprite_container = null

func display_ranges():
	cell_sprite_container.show()

func hide_ranges():
	cell_sprite_container.hide()
