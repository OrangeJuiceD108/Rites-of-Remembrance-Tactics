class_name Attack_Data

var attacker : Unit_Readout
var defender : Unit_Readout
var crit_rate : int
var hit_rate : int
var damage : int

func _init(a: Unit_Readout, d: Unit_Readout, cr: int, hr: int, dmg: int):
	attacker = a
	defender = d
	crit_rate = cr
	hit_rate = hr
	damage = dmg

static func generate(atk: Battle_Sheet, def: Battle_Sheet):
	var cr = atk.crit_rate - def.crit_rate
	var accuracy = atk.accuracy - def.avoid
	var dmg = atk.attack - (def.defense if atk.weapon.data.physical else def.resistance)
	
	return Attack_Data.new(atk.unit, def.unit, cr, accuracy, dmg)

func duplicate():
	return Attack_Data.new(attacker, defender, crit_rate, hit_rate, damage)
