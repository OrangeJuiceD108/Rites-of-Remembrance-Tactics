class_name Player_Unit_Manager extends Node

var player_units: Array[Player_Unit]

func _ready() -> void:
	for child in get_children():
		if child is Player_Unit:
			player_units.append(child)

# TODO: Implement get_unit_at_cell
func get_unit_at_cell(cell: Vector2i) -> Player_Unit:
	push_error("not implemented")

# TODO: Implement select_unit
func select_unit(unit: Player_Unit):
	# Should gen move radius, attack radius
	pass
