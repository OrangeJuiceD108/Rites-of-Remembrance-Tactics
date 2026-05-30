class_name Weapon_Data extends Equipment_Data

@export var type : Constants.WeaponType

enum WeaponRank {
	S = 5, 
	A = 4, 
	B = 3,
	C = 2, 
	D = 1, 
	E = 0
}
@export var weapon_rank : WeaponRank

@export var attack_range : Vector2i

@export var weight : int

@export var might : int

@export var hit_rate : int

@export var crit_rate : int

@export var weapon_experience : int

@export var base_durability : int

# If signature weapon of a specific unit, this stores the name; otherwise null
@export var signature_unit : String 

@export var physical : bool

@export var reaver : bool

@export var skills : Array[Skill]
