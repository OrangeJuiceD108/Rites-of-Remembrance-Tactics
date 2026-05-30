@abstract
class_name Skill extends Resource

var name : String

enum CallSignal {BATTLE_STARTED, ATTACK_CALCULATING, ATTACK_LANDED, BATTLE_ENDED}
var call_signals : Array[CallSignal]

enum SkillSource {NONE, UNIT, ITEM, WEAPON}
var skill_source : SkillSource = SkillSource.NONE

# FIXME: Wrong data types
var attached_item : Item_Data
var attached_weapon : Weapon_Data
var attached_unit : Unit

func _init():
	assert(name != "", get_script().get_global_name() + " has not set name!")
	assert(skill_source != SkillSource.NONE, get_script().get_global_name() + " has not set skill_source!")

@abstract
# TODO: Add types (unit: Unit, weapon: Weapon)
func on_equip()

@abstract
# TODO: Add types (attacker_stats: Unit_Readout, defender_stats: Unit_Readout)
func on_battle_started()

@abstract
# TODO: Add types (attacker_sheet: Battle_Sheet, defender_sheet: Battle_Sheet)
func on_attack_calculating()

@abstract
# TODO: Add types (attacks: Array[int], attacker: Array[Unit]
func on_attack_sequencing()

@abstract
# TODO: Add types (attacker_stats: Unit_Readout, defender_stats: Unit_Readout, damage: int)
func on_attack_landed()

@abstract
# TODO: Add types (attacker_report: Battle_Report, defender_report: Battle_Report)
func on_battle_ended()
