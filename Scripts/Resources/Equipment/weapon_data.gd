class_name Weapon_Data extends Equipment_Data

enum Type {ANIMA, AXE, BOW, DARK, EMPTY, LANCE, LIGHT, SWORD}
@export var weapon_type : Type

enum WeaponRank {E, D, C, B, A, S}
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

@export var physical_weapon : bool

@export var reaver : bool

@export var skills : Array[Skill]
