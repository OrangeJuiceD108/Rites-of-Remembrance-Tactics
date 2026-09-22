class_name Battle_Simulator

# FIXME: Units without weapons
# FIXME: Weapon durability
static func run_battle(attacker: Unit, defender: Unit):
	var context : Battle_Context = Battle_Context.generate(attacker, defender)
	
	var atk_sequence = _sequence_attacks(context.attacker_attack, context.defender_attack, context.speed_advantage)
	
	EventBus.on_attack_sequencing.emit(atk_sequence)
	
	var atk_results = _generate_results(atk_sequence)
	
	EventBus.on_attack_landed.emit(atk_results)
	
	var atk_reports = _generate_reports(atk_results)
	
	EventBus.on_battle_ended.emit(atk_reports[context.attacker_sheet.unit], atk_reports[context.defender_sheet.unit])
	
	# TODO: Apply changes
	# Apply Damage
	attacker.hp -= atk_reports[context.attacker_sheet.unit].damage
	defender.hp -= atk_reports[context.defender_sheet.unit].damage
	# Apply Weapon Durability Changes
	# Apply Experience
	# Apply Weapon_Experience

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
	
	var effective_level = {
		attacks[0].attacker: attacks[0].attacker.level,
		attacks[0].defender: attacks[0].defender.level
	}
	
	var accumulated_xp = {
		attacks[0].attacker: 0,
		attacks[0].defender: 0
	}
	
	for i in attacks:
		if not i.hit:
			continue
		
		var attacker = i.attacker
		var defender = i.defender
		
		reports[defender].damage += i.damage
		
		reports[attacker].weapon_experience += attacker.weapon.data.weapon_experience
		var damage_xp = (31 + effective_level[defender] - effective_level[attacker] + defender.unit_class.experience_bonus_damage - attacker.unit_class.experience_bonus_damage) / attacker.unit_class.class_power
		
		reports[attacker].experience += damage_xp
		accumulated_xp[attacker] += damage_xp
		
		if reports[defender].damage >= defender.hp:
			var base_xp_main = effective_level[defender] * defender.unit_class.class_power + defender.unit_class.experience_bonus_defeat
			var base_xp_sub = (effective_level[attacker] * attacker.unit_class.class_power + attacker.unit_class.experience_bonus_defeat)
			if base_xp_main - base_xp_sub <= 0:
				base_xp_sub /= 2
			
			reports[attacker].experience += base_xp_main - base_xp_sub + 20 + defender.unit_class.additional_defeat_bonus
			
			return reports
		
		while accumulated_xp[attacker] >= 100:
			accumulated_xp[attacker] -= 100
			effective_level[attacker] += 1
	
	reports[attacks[0].defender].experience = max(reports[attacks[0].defender].experience, 1)
	reports[attacks[0].attacker].experience = max(reports[attacks[0].attacker].experience, 1)
	
	return reports
