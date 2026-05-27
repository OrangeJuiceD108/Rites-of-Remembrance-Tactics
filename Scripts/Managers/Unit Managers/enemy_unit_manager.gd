class_name Enemy_Unit_Manager extends Node

var enemy_units: Array[Enemy_Unit]
var occupied_tiles : Array[Vector2i]

func _ready() -> void:
	for child in get_children():
		if child is Enemy_Unit:
			enemy_units.append(child)
			occupied_tiles.append(child.grid_position)
