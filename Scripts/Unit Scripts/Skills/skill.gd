@abstract
class_name Skill extends Resource

enum CallSignal {BATTLE_STARTED, ATTACK_CALCULATING, ATTACK_LANDED, BATTLE_ENDED}
var call_signals : Array[CallSignal]

@abstract
# TODO: Add types (attacker_stats: Unit_Readout, defender_stats: Unit_Readout)
func _on_battle_started()

@abstract
# TODO: Add types (attacker_sheet: Battle_Sheet, defender_sheet: Battle_Sheet)
func _on_attack_calculating()

@abstract
# TODO: Add types (attacker_stats: Unit_Readout, defender_stats: Unit_Readout, damage: int)
func _on_attack_landed()

@abstract
# TODO: Add types (attacker_report: Battle_Report, defender_report: Battle_Report)
func _on_battle_ended()
