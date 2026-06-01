class_name Battle_Simulator

static func run_battle(attacker: Unit, defender: Unit):
	var attacker_readout : Unit_Readout = Unit_Readout.new(attacker)
	var defender_readout : Unit_Readout = Unit_Readout.new(defender)
	
	EventBus.on_battle_started.emit(attacker_readout, defender_readout)
	
	var attacker_sheet : Battle_Sheet = Battle_Sheet.new(attacker_readout, defender_readout)
	var defender_sheet : Battle_Sheet = Battle_Sheet.new(defender_readout, attacker_readout)
	
	EventBus.on_attack_calculating.emit(attacker_sheet, defender_sheet)
	
	var atk_attack = _compute_attack_data(attacker_sheet, defender_sheet)
	var def_attack = _compute_attack_data(defender_sheet, attacker_sheet)
	
	var speed_advantage = attacker_sheet.attack_speed - defender_sheet.attack_speed
	
	var atk_sequence = _sequence_attacks(atk_attack, def_attack, speed_advantage)
	
	EventBus.on_attack_sequencing.emit(atk_sequence)
	
	var atk_results = _generate_results(atk_sequence)
	
	EventBus.on_attack_landed.emit(atk_results)
	
	var atk_reports = _generate_reports(atk_results)
	
	EventBus.on_battle_ended.emit(atk_reports[attacker_readout], atk_reports[defender_readout])
	
	# TODO: Apply changes

static func _compute_attack_data(attacker: Battle_Sheet, defender: Battle_Sheet):
	var crit_rate = attacker.crit_rate - defender.crit_rate
	var accuracy = attacker.accuracy - defender.avoid
	var damage = attacker.attack - (defender.defense if attacker.weapon.data.physical else defender.resistance)
	
	return Attack_Data.new(attacker.unit, defender.unit, crit_rate, accuracy, damage)

static func _sequence_attacks(atk_attack: Attack_Data, def_attack: Attack_Data, speed_advantage: int):
	var atk_count = 2 if speed_advantage >= 4 else 1
	var def_count = 2 if speed_advantage <= -4 else 1
	
	var atk_sequence : Array[Attack_Data]
	atk_sequence.append(atk_attack.duplicate())
	
	for i in def_count:
		atk_sequence.append(def_attack.duplicate())
	
	if atk_count > 1:
		atk_sequence.append(atk_attack.duplicate())
	
	return atk_sequence

static func _generate_results(attacks: Array[Attack_Data]):
	var results : Array[Attack_Result]
	for i in attacks:
		var damage = i.damage
		var hit = randi_range(1, 101) <= i.hit_rate
		
		var crit = hit && randi_range(1, 100) <= i.crit_rate
		if crit:
			damage *= 3
		
		results.append(Attack_Result.new(i.attacker, i.defender, crit, hit, damage))
	
	return results

static func _generate_reports(attacks: Array[Attack_Result]):
	var reports = {
		attacks[0].attacker: Battle_Report.new(attacks[0].attacker, attacks),
		attacks[0].defender: Battle_Report.new(attacks[0].defender, attacks)
	}
	
	for i in attacks:
		if not i.hit:
			continue
		
		var attacker = i.attacker
		var defender = i.defender
		
		reports[defender].damage += i.damage
		
		reports[attacker].weapon_experience += attacker.weapon.data.weapon_experience
		reports[attacker].experience += (31 + defender.level - attacker.level + defender.unit_class.experience_bonus_damage - attacker.unit_class.experience_bonus_damage) / attacker.unit_class.class_power
		
		if reports[defender].damage >= defender.hp:
			var base_xp_main = defender.level * defender.unit_class.class_power + defender.unit_class.experience_bonus_defeat
			var base_xp_sub = (attacker.level * attacker.unit_class.class_power + attacker.unit_class.experience_bonus_defeat)
			if base_xp_main - base_xp_sub <= 0:
				base_xp_sub /= 2
			
			reports[attacker].experience += base_xp_main - base_xp_sub + 20 + defender.unit_class.additional_defeat_bonus
			
			break
	
	reports[attacks[0].defender].experience = max(reports[attacks[0].defender].experience, 1)
	reports[attacks[0].attacker].experience = max(reports[attacks[0].attacker].experience, 1)
	
	return reports

class Attack_Data:
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

class Attack_Result:
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

class Battle_Report:
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
