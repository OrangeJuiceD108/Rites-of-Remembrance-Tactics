class_name Weapon extends Equipment

@export var data : Weapon_Data

@export var durability : int

func _ready():
	# FIXME: might change later
	if durability == 0:
		durability = data.base_durability
