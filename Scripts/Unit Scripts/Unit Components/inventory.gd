class_name Inventory extends Node

@export var equipped_weapon : Weapon
var attack_range : Vector2i = Vector2i(999, 0)

func _ready():
	var children = get_children().filter(func(child): return child is Weapon)
	
	for child in children:
		attack_range[0] = attack_range[0] if attack_range[0] <= child.data.attack_range[0] else child.data.attack_range[0]
		attack_range[1] = attack_range[1] if attack_range[1] >= child.data.attack_range[1] else child.data.attack_range[1]

func equip(weapon: Weapon):
	equipped_weapon = weapon
	EventBus.on_equip.emit(get_parent(), weapon)

func add(equipment: Equipment):
	add_child(equipment)
	
	var weapon = equipment as Weapon
	if weapon != null:
		attack_range[0] = attack_range[0] if attack_range[0] <= weapon.data.attack_range[0] else weapon.data.attack_range[0]
		attack_range[1] = attack_range[1] if attack_range[1] >= weapon.data.attack_range[1] else weapon.data.attack_range[1]

func remove(equipment: Equipment):
	if get_node_or_null(NodePath(equipment.name)) == null:
		return
	remove_child(equipment)
	
	var children = get_children().filter(func(child): return child is Weapon)
	
	var new_range = Vector2i(999, 0)
	for child in children:
		new_range[0] = new_range[0] if new_range[0] <= child.data.attack_range[0] else child.data.attack_range[0]
		new_range[1] = new_range[1] if new_range[1] >= child.data.attack_range[1] else child.data.attack_range[1]
