class_name Inventory extends Node

@export var equipped_weapon : Item
var attack_range : Vector2i = Vector2i(999, 0)

signal on_equip(unit: Unit, item: Item)

func _ready():
	_build_range()
	print(attack_range)

# FIXME: Restrict units from equipping weapons that they
#        aren't proficient in or don't have the skills to use
func equip(item: Item):
	if item.get_component(Weapon_Component) != null:
		_equip_weapon(item)
	var equip_effect = item.get_component(Equip_Effect)
	if equip_effect != null:
		equip_effect.equip()

func _equip_weapon(weapon: Item):
	equipped_weapon = weapon
	on_equip.emit(get_parent(), weapon)

func add(item: Item):
	add_child(item)
	
	var weapon_component = item.get_component(Weapon_Component)
	print(weapon_component != null)
	if weapon_component != null:
		attack_range[0] = attack_range[0] if attack_range[0] <= weapon_component.attack_range[0] else weapon_component.attack_range[0]
		attack_range[1] = attack_range[1] if attack_range[1] >= weapon_component.attack_range[1] else weapon_component.attack_range[1]

func remove(item: Item):
	if get_node_or_null(NodePath(item.name)) == null:
		return
	remove_child(item)
	
	_build_range()

func _build_range():
	var weapons = get_items_with_component(Weapon_Component)
	print(weapons)
	
	var new_range = Vector2i(999,0)
	for weapon in weapons:
		var weapon_component = weapon.get_component(Weapon_Component)
		new_range[0] = new_range[0] if new_range[0] <= weapon_component.attack_range[0] else weapon_component.attack_range[0]
		new_range[1] = new_range[1] if new_range[1] >= weapon_component.attack_range[1] else weapon_component.attack_range[1]
	attack_range = new_range

func get_items_with_component(component: Variant):
	var items : Array[Item]
	for child in get_children():
		if child.get_component(component) != null:
			items.append(child)
	return items
