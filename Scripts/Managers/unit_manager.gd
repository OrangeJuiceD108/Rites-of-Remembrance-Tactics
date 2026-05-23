class_name Unit_Manager extends Node

var occupied_tiles: Array[Vector2]

@onready var enemy_manager = get_node("Enemy Unit Manager") as Enemy_Unit_Manager
@onready var player_manager = get_node("Player Unit Manager") as Player_Unit_Manager
@onready var ally_manager = get_node_or_null("Allied Unit Manager") as Allied_Unit_Manger

# TODO: FINISH get_move_radius
func get_move_radius(loc: Vector2) -> Array[Vector2]:
	var final_array : Array[Vector2]
	var queue := [loc]
	var adj := [Vector2(0, 1), Vector2(1, 0), Vector2(0, -1), Vector2(-1, 0)]
	
	while !queue.is_empty():
		var curr_item = queue.pop_back()
		final_array.append(curr_item)
		
		for dir in adj:
			if final_array.has(curr_item + dir):
				continue
			# TODO: Check some stuff here, like for allies
			queue.push_front(curr_item + dir)
	
	return final_array
