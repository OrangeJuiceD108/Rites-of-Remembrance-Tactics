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
