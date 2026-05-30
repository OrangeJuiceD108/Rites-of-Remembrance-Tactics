class_name Unit_Readout extends Node

var unit_class : Unit_Class

var weapon : Weapon

# Base states
var stats : Array[int]
var stat_multipliers : Array[int]

# Same as base stats unless a skill like Rightful King modifies skill activation rate
var activation_rate_stats : Array[int]
var activation_multipliers : Array[int]

var constitution : int

var tags : Array[Unit_Class.Tag]

# TODO: Finish constructor
func _init(unit: Unit):
	unit_class = unit.unit_class
	
	# TODO: Assign the weapon
	
	# TODO: Assign stats
	activation_rate_stats = stats.duplicate()
	
	stat_multipliers.resize(8)
	stat_multipliers.fill(1)
	activation_multipliers.resize(8)
	activation_multipliers.fill(1)
	
	#TODO: Assign constitution
	
	tags = unit.unit_class.tags
