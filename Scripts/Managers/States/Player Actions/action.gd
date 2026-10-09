@abstract
class_name Action extends Node

enum Type {TALK, ATTACK, HEAL, TELEPORT, RESCUE, TRADE, ITEMS, WAIT}
var type : Type
var action_name : String

@abstract
func is_available(unit: Unit, cell: Vector2i) -> bool

func action_selected():
	pass

func confirm(_kwargs: Array):
	pass

func cancel():
	pass
