class_name Unit_Readout extends Node

var unit_class : Unit_Class
var level : int

var weapon : Weapon

# Base states
var hp : int
var stats : Dictionary[Constants.Stat, int]
var stat_multipliers : Array[int]

# Same as base stats unless a skill like Rightful King modifies skill activation rate
var activation_rate_stats : Dictionary[Constants.Stat, int]
var activation_multipliers : Array[int]

var constitution : int

var tags : Array[Unit_Class.Tag]

func _init(unit: Unit):
	unit_class = unit.unit_class
	level = unit.level
	
	weapon = unit.inventory.equipped_weapon
	
	hp = unit.hp
	stats = unit.stats
	activation_rate_stats = stats.duplicate()
	
	stat_multipliers.resize(8)
	stat_multipliers.fill(1)
	activation_multipliers.resize(8)
	activation_multipliers.fill(1)
	
	constitution = unit.constitution
	
	tags = unit.unit_class.tags
