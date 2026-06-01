class_name Inventory_Menu extends VBoxContainer

@export var button_scene : PackedScene

signal weapon_chosen()

func build_attack(inventory: Inventory):
	for child in get_children():
		child.queue_free()
	
	for weapon in inventory.get_weapons():
		_add_weapon_button(weapon, inventory)

func _add_weapon_button(weapon: Weapon, inventory: Inventory):
	var button = button_scene.instantiate()
	button.get_node("Name").text = weapon.data.name
	button.get_node("Durability").text = str(weapon.durability)
	button.pressed.connect(_weapon_clicked.bind(weapon, inventory))
	add_child(button)

func _weapon_clicked(weapon: Weapon, inventory: Inventory):
	inventory.equip(weapon)
	weapon_chosen.emit()

func build_item():
	for child in get_children():
		child.queue_free()
	
	# TODO: Complete items menu
