class_name Unit_Summary extends VBoxContainer

@onready var type = $"PanelContainer/VBoxContainer/Type/Type"
@onready var atk = $"PanelContainer/VBoxContainer/Atk Crit Container/Attack/Atk"
@onready var crit = $"PanelContainer/VBoxContainer/Atk Crit Container/Critical/Crit"
@onready var hit = $"PanelContainer/VBoxContainer/Hit Avoid Container/Hit/Hit"
@onready var avoid = $"PanelContainer/VBoxContainer/Hit Avoid Container/Avoid/Avoid"

var unit : Unit

func _ready(): 
	var viewport_size = get_viewport_rect().size
	var height_fraction = size.y / viewport_size.y
	var width_fraction = size.x / viewport_size.x
	
	anchor_bottom = 0.98
	anchor_top = anchor_bottom - height_fraction
	anchor_right = 0.98
	anchor_left = anchor_right - width_fraction

func build_summary(u: Unit):
	unit = u
	# TODO: Change photo here
	populate_summary()

func populate_summary():
	var weapon = unit.inventory.equipped_weapon
	
	atk.text = str(weapon.data.might + unit.stats[Constants.Stat.STR])
	
	crit.text = str(weapon.data.crit_rate + unit.stats[Constants.Stat.SKL])
	
	@warning_ignore("integer_division")
	hit.text = str(weapon.data.hit_rate + unit.stats[Constants.Stat.SKL] * 2 + unit.stats[Constants.Stat.LCK] / 2)
	
	var restrictive_weight = max(weapon.data.weight - unit.constitution, 0)
	var attack_speed = unit.stats[Constants.Stat.SPD] - restrictive_weight
	avoid.text = str(attack_speed * 2 + unit.stats[Constants.Stat.LCK])
