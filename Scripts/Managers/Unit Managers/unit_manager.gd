class_name Unit_Manager extends Node

@export var enemy_registry : Enemy_Registry

var faction_managers : Dictionary[Faction, Faction_Manager]
var occupied_tiles : Array[Vector2i]:
	get: 
		var tiles : Array[Vector2i]
		for manager in faction_managers.values():
			tiles.append(manager.occupied_tiles)
		return tiles

func _ready():
	for child in get_children():
		faction_managers[child.faction] = child

func get_unit_at_cell(cell: Vector2i, faction : Faction = null):
	if faction != null:
		return faction_managers[faction].get_unit_at_cell(cell)
	
	for child in get_children():
		var unit : Unit = child.get_unit_at_cell(cell)
		if unit != null:
			return unit
	return null

func get_units_of_faction(faction: Faction):
	return faction_managers[faction].units

func are_hostile(one: Unit, two: Unit):
	return enemy_registry.are_hostile(one.faction, two.faction)
