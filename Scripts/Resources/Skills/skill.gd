@abstract
class_name Skill extends Resource

var name : String

enum CallSignal {EQUIP, BATTLE_STARTED, ATTACK_CALCULATING, ATTACK_SEQUENCING, ATTACK_LANDED, BATTLE_ENDED}
var call_signals : Array[CallSignal]

enum SkillSource {NONE, UNIT, ITEM, WEAPON}
var skill_source : SkillSource = SkillSource.NONE

# FIXME: Wrong data types
var attached_item : Item_Data
var attached_weapon : Weapon
var attached_unit : Unit

func _init():
	assert(name != "", get_script().get_global_name() + " has not set name!")
	assert(skill_source != SkillSource.NONE, get_script().get_global_name() + " has not set skill_source!")

@abstract
func on_equip(unit: Unit, weapon: Weapon)

@abstract
func on_battle_started(attacker_readout: Unit_Readout, defender_readout: Unit_Readout)

@abstract
func on_attack_calculating(attacker_sheet: Battle_Sheet, defender_sheet: Battle_Sheet)

@abstract
func on_attack_sequencing(attacks: Array[Battle_Simulator.Attack_Data])

@abstract
func on_attack_landed(attack_results: Array[Battle_Simulator.Attack_Result])

@abstract
func on_battle_ended(attacker_report: Battle_Simulator.Battle_Report, defender_report: Battle_Simulator.Battle_Report)
