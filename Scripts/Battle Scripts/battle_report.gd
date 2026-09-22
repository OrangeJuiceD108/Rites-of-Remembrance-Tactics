class_name Battle_Report

var unit : Unit_Readout
var attack_sequence : Array[Attack_Result]
var damage : int
var experience : int
var weapon_experience : int

func _init(u: Unit_Readout, atks: Array[Attack_Result]):
	unit = u
	attack_sequence = atks
	damage = 0
	experience = 0
	weapon_experience = 0
