class_name Allied_Unit_Manger extends Node

var allied_units: Array[Allied_Unit]

func _ready() -> void:
	for child in get_children():
		if child is Allied_Unit:
			allied_units.append(child)
