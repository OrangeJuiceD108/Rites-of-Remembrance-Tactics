extends Node

@warning_ignore("unused_signal")
signal on_equip(unit: Unit, weapon: Weapon)

@warning_ignore("unused_signal")
signal on_battle_started(attacker_readout: Unit_Readout, defender_readout: Unit_Readout)

@warning_ignore("unused_signal")
signal on_attack_calculating(attacker_sheet: Battle_Sheet, defender_sheet: Battle_Sheet)

@warning_ignore("unused_signal")
signal on_attack_sequencing(attacks: Array[Battle_Simulator.Attack_Data])

@warning_ignore("unused_signal")
signal on_attack_landed(attack_results: Array[Battle_Simulator.Attack_Result])

@warning_ignore("unused_signal")
signal on_battle_ended(attacker_report: Battle_Simulator.Battle_Report, defender_report: Battle_Simulator.Battle_Report)
