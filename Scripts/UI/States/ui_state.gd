@abstract
class_name UI_State extends Node

var state : State
enum State {IDLE, ACTIONS_MENU, WEAPONS_MENU, BATTLE_PREVIEW}

func enter(_kwargs: Dictionary):
	pass

func exit():
	pass

func update_target_cell(_cell: Vector2i):
	pass
