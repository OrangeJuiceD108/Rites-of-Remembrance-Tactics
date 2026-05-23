class_name Unit extends Node2D

var grid_position : Vector2
var move_radius : Array[Vector2]

static func is_opposing_faction(unit_1: Unit, unit_2: Unit) -> bool:
	if (unit_1 is Player_Unit or unit_1 is Allied_Unit) and unit_2 is Enemy_Unit:
		return true
	if unit_1 is Enemy_Unit and (unit_2 is Player_Unit or unit_2 is Allied_Unit):
		return true
	return false

# TODO: Change position func
func change_position(grid_pos: Vector2):
	grid_position = grid_pos
	# TODO: Change physical position
