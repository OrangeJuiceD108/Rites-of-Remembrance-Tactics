class_name Attack_Result

var attacker : Unit_Readout
var defender : Unit_Readout
var crit : bool
var hit : bool
var damage : int

func _init(a: Unit_Readout, d: Unit_Readout, c: bool, h: bool, dmg: int):
	attacker = a
	defender = d
	crit = c
	hit = h
	damage = dmg
