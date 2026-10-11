class_name Faction_Manager extends Node

@export var faction : Faction

var units: Array[Unit]
var occupied_tiles : Array[Vector2i]:
	get:
		var tiles : Array[Vector2i]
		for unit in units:
			tiles.append(unit.grid_position)
		return tiles

func _ready():
	for child in get_children():
		if child is Unit:
			units.append(child)
			child.faction = faction

func get_unit_at_cell(cell: Vector2i):
	for unit in units:
		if unit.grid_position == cell:
			return unit
	return null
