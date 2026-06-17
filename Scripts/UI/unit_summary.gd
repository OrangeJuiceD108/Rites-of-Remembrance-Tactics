class_name Unit_Summary extends VBoxContainer

@onready var type = $"PanelContainer/VBoxContainer/Type/Type"
@onready var atk = $"PanelContainer/VBoxContainer/Atk Crit Container/Attack/Atk"
@onready var crit = $"PanelContainer/VBoxContainer/Atk Crit Container/Critical/Crit"
@onready var hit = $"PanelContainer/VBoxContainer/Hit Avoid Container/Hit/Hit"
@onready var avoid = $"PanelContainer/VBoxContainer/Hit Avoid Container/Avoid/Avoid"

var unit : Unit

func _ready(): 
	var anchors = Constants.get_anchors_for_corner(self, Vector2i.DOWN + Vector2i.RIGHT)
	anchor_top = anchors[Vector2i.UP]
	anchor_bottom = anchors[Vector2i.DOWN]
	anchor_left = anchors[Vector2i.LEFT]
	anchor_right = anchors[Vector2i.RIGHT]

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
