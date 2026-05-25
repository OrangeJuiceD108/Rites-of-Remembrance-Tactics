class_name Unit_Manager extends Node

var occupied_tiles: Array[Vector2i]

@onready var enemy_manager = get_node("Enemy Unit Manager") as Enemy_Unit_Manager
@onready var player_manager = get_node("Player Unit Manager") as Player_Unit_Manager
@onready var ally_manager = get_node_or_null("Allied Unit Manager") as Allied_Unit_Manger
