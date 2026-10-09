@abstract
class_name Player_Turn_State extends Node

enum State {IDLE, UNIT_SELECTED, UNIT_STAGED, ACTION_SELECTED} 
var state : State

var player_faction : Faction
var controller : Player_Turn_Controller

func enter(_kwargs: Dictionary):
	pass

func cell_clicked(_cell: Vector2i):
	pass

func exit():
	pass
