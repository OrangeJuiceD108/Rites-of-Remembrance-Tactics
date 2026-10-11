@abstract
class_name Action extends Node

enum Type {TALK, ATTACK, HEAL, TELEPORT, RESCUE, TRADE, ITEMS, WAIT}
var type : Type
var action_name : String

var controller : Player_Turn_Controller

@abstract
func is_available() -> bool

func get_targetable_cells():
	pass

func action_selected():
	pass

func on_targeting():
	pass

func confirm_cell(_cell: Vector2i):
	pass

func cancel():
	pass
