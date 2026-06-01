class_name Inventory extends Node

@export var equipped_weapon : Weapon
@export var attack_range : Vector2i # FIXME: Temporarily an exported field

func equip(weapon: Weapon):
	equipped_weapon = weapon
	EventBus.on_equip.emit(get_parent(), weapon)

# FIXME: Finish get_attack_range
# Maybe have attack_range just call this function?
# Maybe have an inventory_add and inventory_remove
#   so that we can compute the attack_range only
#   when it changes?
func get_attack_range():
	pass
