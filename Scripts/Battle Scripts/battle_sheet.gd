class_name Battle_Sheet extends Node

var unit : Unit_Readout

# Speed of attacker
var attack_speed : int:
	get:
		var restrictive_weight = weapon.get_component(Weapon_Component).weight - unit.constitution
		if restrictive_weight < 0:
			restrictive_weight = 0
		return unit.stats[Constants.Stat.SPD] - restrictive_weight + attack_speed_mod
var attack_speed_mod : int

var attack : int:
	get:
		var weapon_component = weapon.get_component(Weapon_Component)
		var atk = (weapon_component.might + advantage) + effective_bonus + attack_mod
		if weapon_component.physical:
			atk += unit.stats[Constants.Stat.STR]
		else:
			atk += unit.stats[Constants.Stat.MAG]
		return atk
var attack_mod : int

var accuracy : int:
	get:
		@warning_ignore("integer_division")
		return weapon.get_component(Weapon_Component).hit_rate + (unit.stats[Constants.Stat.SKL] * 2) + (unit.stats[Constants.Stat.LCK] / 2) + (advantage * 15) + accuracy_mod
var accuracy_mod : int

var crit_rate : int:
	get:
		@warning_ignore("integer_division")
		return weapon.get_component(Weapon_Component).crit_rate + (unit.stats[Constants.Stat.SKL] / 2) + crit_rate_mod
var crit_rate_mod : int

var weapon : Item

enum Advantage {
	ADVANTAGE = 1,
	NEUTRAL = 0,
	DISADVANTAGE = -1
}
var advantage : Advantage

var effective_bonus : int

var defense : int:
	get:
		return unit.stats[Constants.Stat.DEF] + defense_mod
var defense_mod : int

var resistance : int:
	get:
		return unit.stats[Constants.Stat.RES] + resistance_mod
var resistance_mod : int

var avoid : int:
	get:
		return attack_speed * 2 + unit.stats[Constants.Stat.LCK] + avoid_mod
var avoid_mod : int

var crit_evade : int:
	get: 
		return unit.stats[Constants.Stat.LCK] + crit_evade_mod
var crit_evade_mod

func _init(unit_readout: Unit_Readout, enemy_readout: Unit_Readout):
	unit = unit_readout
	
	weapon = unit.weapon
	var enemy_weapon = enemy_readout.weapon
	
	if weapon_advantage(weapon, enemy_weapon):
		advantage = Advantage.ADVANTAGE
	elif weapon_advantage(enemy_weapon, weapon):
		advantage = Advantage.DISADVANTAGE
	else: 
		advantage = Advantage.NEUTRAL
	
	effective_bonus = 1

static func weapon_advantage(one: Item, two: Item):
	var weapon_one = one.get_component(Weapon_Component)
	var weapon_two = two.get_component(Weapon_Component)
	if not weapon_one.reaver and not weapon_two.reaver and Constants.WeaponAdvantage[weapon_one.type] == weapon_two.type:
		return true
	if weapon_one.reaver and weapon_two.reaver and Constants.WeaponAdvantage[weapon_one.type] == weapon_two.type:
		return true
	if weapon_one.reaver != weapon_two.reaver and Constants.WeaponAdvantage[weapon_two.type] == weapon_one.type:
		return true
	return false
