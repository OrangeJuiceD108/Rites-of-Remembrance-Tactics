@abstract
class_name Unit extends Node2D

var grid_position : Vector2i 

@export var unit_class : Unit_Class

var level : int
var experience : int

var weapon_rank : Weapon_Data.WeaponRank
var weapon_experience : int

var hp : int
var stats : Dictionary[Constants.Stat, int] 
var constitution : int 
var move_speed : int 

@onready var sprite : Sprite2D = $"Sprite2D"
@onready var inventory : Inventory = $"Inventory"

func _ready():
	grid_position = GameState.grid.get_cell(position) #FIXME This way of instantiating grid position probably isn't permanent
	
	# FIXME: Need to handle units that are higher than level one
	if stats.size() == 0:
		level = 1
		stats = unit_class.base_stats.duplicate()
		constitution = unit_class.base_constitution
		move_speed = unit_class.base_speed
	
	hp = stats[Constants.Stat.HP]

static func is_opposing_faction(unit_1: Unit, unit_2: Unit) -> bool:
	if (unit_1 is Player_Unit or unit_1 is Allied_Unit) and unit_2 is Enemy_Unit:
		return true
	if unit_1 is Enemy_Unit and (unit_2 is Player_Unit or unit_2 is Allied_Unit):
		return true
	return false

func change_position(cell: Vector2i):
	position = GameState.grid.get_loc_by_cell(cell)
	grid_position = cell

# FIXME: Finish get_move_radius
func get_move_radius() -> Array[Vector2i]:
	var final_array : Array[Vector2i]
	var queue := [[grid_position, 0]]
	var adjacencies := [Vector2i(0, 1), Vector2i(1, 0), Vector2i(0, -1), Vector2i(-1, 0)]
	
	while !queue.is_empty():
		var current_item = queue.pop_back()
		final_array.append(current_item[0])
		
		if current_item[1] >= move_speed:
			continue
		
		for direction in adjacencies:
			if final_array.has(current_item[0] + direction):
				continue
			# TODO: Add other checks here!
			
			queue.push_front([current_item[0] + direction, current_item[1] + 1])
	
	return final_array

func get_attack_radius(move_radius: Array[Vector2i]) -> Array[Vector2i]:
	var final_array : Array[Vector2i]
	var offsets := _get_attack_offsets(inventory.attack_range[0], inventory.attack_range[1])
	
	for tile in move_radius:
		for o in offsets:
			var new_tile = tile + o
			if !final_array.has(new_tile):
				final_array.append(new_tile)
	
	return final_array

func _get_attack_offsets(min_range: int, max_range: int) -> Array[Vector2i]:
	var offsets : Array[Vector2i]
	for x in range(-max_range, max_range + 1):
		for y in range(-max_range, max_range + 1):
			var dist = abs(x) + abs(y)
			if min_range <= dist && dist <= max_range:
				offsets.append(Vector2i(x, y))
	return offsets
