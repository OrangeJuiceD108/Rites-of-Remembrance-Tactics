@abstract
class_name Use_Effect extends Resource

var name : String

func _init():
	assert(name != "", get_script().get_global_name() + " has not set name!")

@abstract
func on_use(unit)
