class_name Battle_Preview

var attacker_sheet : Battle_Sheet
var attacker_attack : Attack_Data
var attacker_attack_count : int

var defender_sheet : Battle_Sheet
var defender_attack : Attack_Data
var defender_attack_count : int

func _init(atk: Battle_Sheet, def: Battle_Sheet, a_atk: Attack_Data, d_atk: Attack_Data, speed_advantage: int):
	attacker_sheet = atk
	defender_sheet = def
	attacker_attack = a_atk
	defender_attack = d_atk
	attacker_attack_count = 2 if speed_advantage >= 4 else 1
	defender_attack_count = 2 if speed_advantage <= -4 else 1

static func generate(attacker: Unit, defender: Unit):
	var context : Battle_Context = Battle_Context.generate(attacker, defender)
	
	var battle_preview : Battle_Preview = Battle_Preview.new(context.attacker_sheet, context.defender_sheet, context.attacker_attack, context.defender_attack, context.speed_advantage)
	
	EventBus.on_battle_previewing.emit(battle_preview)
	
	return battle_preview
