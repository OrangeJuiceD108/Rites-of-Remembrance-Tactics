class_name Unit_Class extends Resource

@export var name : String

@export var default_portrait : Texture2D

@export var proficiencies : Array[Weapon_Data.Type]

@export var promotions : Array[Unit_Class]

enum Tag {ARMORED, BEAST, DRAGON, MONSTER, UNARMORED}
@export var tags : Array[Tag]

@export var skills : Array[Skill]

@export var base_speed : int

@export var base_constitution : int

@export var base_growth_rates : Array[int] = [80, 40, 40, 30, 25, 30, 20, 20]
@export var base_stats : Array[int] = [18, 5, 5, 5, 5, 0, 5, 3]
@export var promotion_gains : Array[int] = [0, 0, 0, 0, 0, 0, 0, 0]
