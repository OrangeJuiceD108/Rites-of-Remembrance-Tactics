class_name Player_Unit_Manager extends Node

var player_units: Array[Player_Unit]

func _ready() -> void:
	for child in get_children():
		if child is Player_Unit:
			player_units.append(child)
