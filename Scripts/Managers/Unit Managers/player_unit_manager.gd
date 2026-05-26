class_name Player_Unit_Manager extends Node

var player_units: Array[Player_Unit]

func _ready() -> void:
	for child in get_children():
		if child is Player_Unit:
			player_units.append(child)

func get_unit_at_cell(cell: Vector2i) -> Player_Unit:
	for unit in player_units:
		if unit.grid_position == cell:
			return unit
	return null

# TODO: Implement select_unit
func select_unit(unit: Player_Unit):
	# Should gen move radius, attack radius
	pass
