@abstract
class_name Turn_Controller extends Node

@export var faction : Faction:
	set(value):
		if value == null:
			print_stack()
			breakpoint
		faction = value

func _ready():
	assert(faction != null, "Factionless turn controller!")
