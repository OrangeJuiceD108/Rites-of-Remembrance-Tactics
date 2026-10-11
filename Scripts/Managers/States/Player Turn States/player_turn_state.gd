@abstract
class_name Player_Turn_State extends Node

enum State {IDLE, SELECTING_DESTINATION, SELECTING_ACTION, SELECTING_ITEM, TARGETING} 
var state : State

var faction : Faction
var controller : Player_Turn_Controller

func enter(_kwargs: Dictionary):
	pass

func cell_clicked(_cell: Vector2i):
	pass

func exit():
	pass
