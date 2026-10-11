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

func show_element(new_unit: Unit):
	_build_summary(new_unit)
	unit.inventory.on_equip.connect(_rebuild_summary)
	visible = true

func hide_element():
	unit.inventory.on_equip.disconnect(_rebuild_summary)
	visible = false

func _build_summary(u: Unit):
	unit = u
	# TODO: Change photo here
	populate_summary()

func _rebuild_summary(_unit: Unit, _item: Item):
	populate_summary()

func populate_summary():
	var weapon = unit.inventory.equipped_weapon.get_component(Weapon_Component)
	
	atk.text = str(weapon.might + unit.stats[Constants.Stat.STR])
	
	crit.text = str(weapon.crit_rate + unit.stats[Constants.Stat.SKL])
	
	@warning_ignore("integer_division")
	hit.text = str(weapon.hit_rate + unit.stats[Constants.Stat.SKL] * 2 + unit.stats[Constants.Stat.LCK] / 2)
	
	var restrictive_weight = max(weapon.weight - unit.constitution, 0)
	var attack_speed = unit.stats[Constants.Stat.SPD] - restrictive_weight
	avoid.text = str(attack_speed * 2 + unit.stats[Constants.Stat.LCK])
