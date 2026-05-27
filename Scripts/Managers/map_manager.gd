class_name Map_Manager extends Node

@export var map_data : Map_Data

func _ready():
	GameState.grid = map_data.grid
