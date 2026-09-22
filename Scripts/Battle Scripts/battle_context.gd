class_name Battle_Context

var attacker_sheet : Battle_Sheet
var defender_sheet : Battle_Sheet

var attacker_attack : Attack_Data
var defender_attack : Attack_Data

var speed_advantage : int

func _init(atk_sheet: Battle_Sheet, def_sheet: Battle_Sheet, atk_attack: Attack_Data, def_attack: Attack_Data, spd_adv: int):
	attacker_sheet = atk_sheet
	defender_sheet = def_sheet
	
	attacker_attack = atk_attack
	defender_attack = def_attack
	
	speed_advantage = spd_adv

static func generate(attacker: Unit, defender: Unit):
	var attacker_readout : Unit_Readout = Unit_Readout.new(attacker)
	var defender_readout : Unit_Readout = Unit_Readout.new(defender)
	
	EventBus.on_battle_started.emit(attacker_readout, defender_readout)
	
	var atk_sheet : Battle_Sheet = Battle_Sheet.new(attacker_readout, defender_readout)
	var def_sheet : Battle_Sheet = Battle_Sheet.new(defender_readout, attacker_readout)
	
	EventBus.on_attack_calculating.emit(attacker_sheet, defender_sheet)
	
	var atk_attack = Attack_Data.generate(attacker_sheet, defender_sheet)
	var def_attack = Attack_Data.generate(defender_sheet, attacker_sheet)
	
	var spd_adv = attacker_sheet.attack_speed - defender_sheet.attack_speed
	
	return Battle_Context.new(atk_sheet, def_sheet, atk_attack, def_attack, spd_adv)
