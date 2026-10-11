class_name Item extends Node

@export var item_name : String
@export var description : String = "-"

@export var breakable : bool = false

@export var max_durability : int = 0
# FIXME: REMOVE EXPORT
@export var durability : int = -1

@export var cost : int = 0

func _ready(): 
	if durability == -1:
		durability = max_durability

func get_component(type: Variant):
	for child in get_children():
		if is_instance_of(child, type):
			return child
	return null
