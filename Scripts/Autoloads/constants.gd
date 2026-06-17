extends Node

enum ActionFlags {
	NONE = 0,
	WAIT = 1,
	ITEMS = 2,
	TRADE = 4,
	RESCUE = 8,
	TELEPORT = 16,
	HEAL = 32,
	ATTACK = 64,
	TALK = 128,
}

enum Stat {
	HP = 0,
	STR = 1,
	MAG = 2,
	SKL = 3,
	SPD = 4,
	LCK = 5,
	DEF = 6,
	RES = 7
}

enum WeaponType {
	NONE,
	ANIMA, 
	AXE, 
	BOW, 
	DARK, 
	EMPTY, 
	LANCE, 
	LIGHT, 
	SWORD
}

var WeaponAdvantage = {
	WeaponType.ANIMA:
		WeaponType.LIGHT,
	WeaponType.AXE:
		WeaponType.LANCE,
	WeaponType.BOW:
		WeaponType.NONE,
	WeaponType.DARK:
		WeaponType.LIGHT,
	WeaponType.EMPTY:
		WeaponType.NONE,
	WeaponType.LANCE:
		WeaponType.SWORD,
	WeaponType.LIGHT:
		WeaponType.DARK,
	WeaponType.SWORD:
		WeaponType.AXE
}

func get_anchors_for_corner(ui_element: Control, corner: Vector2i):
	if corner.x == 0 || corner.y == 0:
		push_error("Incorrect vector for get_anchors_for_corner")
	
	var viewport_size = ui_element.get_viewport_rect().size
	var height_fraction = ui_element.size.y / viewport_size.y
	var width_fraction = ui_element.size.x / viewport_size.x
	
	var anchors : Dictionary
	
	if corner.x == Vector2i.RIGHT.x:
		anchors[Vector2i.RIGHT] = 0.98
		anchors[Vector2i.LEFT] = 0.98 - width_fraction
	else: 
		anchors[Vector2i.RIGHT] = 0.02 + width_fraction
		anchors[Vector2i.LEFT] = 0.02
	
	if corner.y == Vector2i.UP.y:
		anchors[Vector2i.UP] = 0.02
		anchors[Vector2i.DOWN] = 0.02 + height_fraction
	else:
		anchors[Vector2i.UP] = 0.98 - height_fraction
		anchors[Vector2i.DOWN] = 0.98
	
	return anchors
