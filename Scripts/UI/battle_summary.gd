class_name Battle_Summary extends PanelContainer

@onready var player_unit_name := $"VBoxContainer/Layer 1/Hbox/Player Unit"
@onready var player_stats := $"VBoxContainer/Layer 2/PanelContainer/Player Stats"
@onready var player_weapon_image := $"VBoxContainer/Layer 1/Hbox/Player Weapon Image"

@onready var enemy_unit_name := $"VBoxContainer/Layer3/Vbox/Hbox/Enemy Unit"
@onready var enemy_stats := $"VBoxContainer/Layer 2/PanelContainer2/Enemy Stats"
@onready var enemy_weapon := $"VBoxContainer/Layer3/Vbox/Enemy Weapon"
@onready var enemy_weapon_image := $"VBoxContainer/Layer3/Vbox/Enemy Weapon"

func update_preview(player: Unit, enemy: Unit):
	var preview = Battle_Preview.generate(player, enemy)
	
	player_unit_name.text = player.name
	_update_stats(player_stats, preview.attacker_sheet, preview.attacker_attack)
	# TODO: Assign weapon image
	
	enemy_unit_name.text = enemy.name
	_update_stats(enemy_stats, preview.defender_sheet, preview.defender_attack)
	enemy_weapon.text = preview.defender_sheet.weapon.data.name
	# TODO: Assign weapon image

func _update_stats(stats: VBoxContainer, sheet: Battle_Sheet, attack: Attack_Data):
	stats.get_node("HP").text = sheet.unit.hp
	stats.get_node("Mt").text = str(attack.damage)
	stats.get_node("Hit").text = str(attack.hit_rate)
	stats.get_node("Crit").text = str(attack.crit_rate)

func shift_corner(loc: Vector2i):
	if loc != Vector2i.LEFT && loc != Vector2i.RIGHT:
		push_error("Incorrect shift params for Battle Summary")
	
	var anchors = Constants.get_anchors_for_corner(self, loc + Vector2i.UP)
	anchor_top = anchors[Vector2i.UP]
	anchor_bottom = anchors[Vector2i.DOWN]
	anchor_left = anchors[Vector2i.LEFT]
	anchor_right = anchors[Vector2i.RIGHT]
	
	offset_top = 0
	offset_bottom = 0
	offset_left = 0
	offset_right = 0
