class_name Unit_Class extends Resource

@export var name : String

@export var default_portrait : Texture2D

@export var proficiencies : Array[Constants.WeaponType]

@export var promotions : Array[Unit_Class]

enum Tag {ARMORED, BEAST, DRAGON, MONSTER, UNARMORED}
@export var tags : Array[Tag]

@export var skills : Array[Skill]

@export var base_speed : int

@export var base_constitution : int

@export var base_growth_rates : Dictionary[Constants.Stat, int] = {
	Constants.Stat.HP : 80,
	Constants.Stat.STR : 40,
	Constants.Stat.MAG : 40,
	Constants.Stat.SKL : 30,
	Constants.Stat.SPD : 25,
	Constants.Stat.LCK : 30,
	Constants.Stat.DEF : 20,
	Constants.Stat.RES : 20,
	}

@export var base_stats : Dictionary[Constants.Stat, int] = {
	Constants.Stat.HP : 18,
	Constants.Stat.STR : 5,
	Constants.Stat.MAG : 5,
	Constants.Stat.SKL : 5,
	Constants.Stat.SPD : 5,
	Constants.Stat.LCK : 0,
	Constants.Stat.DEF : 5,
	Constants.Stat.RES : 3,
	}
@export var promotion_gains : Dictionary[Constants.Stat, int] = {
	Constants.Stat.HP : 0,
	Constants.Stat.STR : 0,
	Constants.Stat.MAG : 0,
	Constants.Stat.SKL : 0,
	Constants.Stat.SPD : 0,
	Constants.Stat.LCK : 0,
	Constants.Stat.DEF : 0,
	Constants.Stat.RES : 0,
	}

@export var experience_bonus_damage : int = 0
@export var experience_bonus_defeat : int = 0
@export var additional_defeat_bonus : int = 0

@export var class_power : int = 3
