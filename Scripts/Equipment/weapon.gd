class_name Weapon extends Equipment

@export var data : Weapon_Data

var durability : int

func _ready():
	durability = data.base_durability # FIXME: might change later
