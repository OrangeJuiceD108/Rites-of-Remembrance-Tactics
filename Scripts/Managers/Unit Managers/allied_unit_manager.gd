class_name Allied_Unit_Manger extends Node

var units: Array[Allied_Unit]
var occupied_tiles : Array[Vector2i]

func _ready() -> void:
	for child in get_children():
		if child is Allied_Unit:
			units.append(child)
			occupied_tiles.append(child.grid_position)

func get_unit_at_cell(cell: Vector2i):
	if !occupied_tiles.has(cell):
		return null
	
	for unit in units:
		if unit.grid_position == cell:
			return unit
	
	push_error("Tile incorrectly occupied")
	return null
