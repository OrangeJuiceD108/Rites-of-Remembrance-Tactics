@abstract
class_name Turn_Controller extends Node

@export var faction : Faction

func _init():
	if faction == null:
		push_error("Factionless turn controller!")
