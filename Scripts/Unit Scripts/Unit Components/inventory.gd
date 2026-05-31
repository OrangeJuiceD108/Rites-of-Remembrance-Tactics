class_name Inventory extends Node

@export var equipped_weapon : Weapon
@export var attack_range : Vector2i # FIXME: Temporarily an exported field

func equip(weapon: Weapon):
	equipped_weapon = weapon
	EventBus.on_equip.emit(get_parent(), weapon)
