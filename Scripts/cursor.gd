class_name Cursor extends Node2D


var cursor_position := Vector2.ZERO

@onready var map_manager = get_node("../Map Manager") as Map_Manager

# TODO: Needs to check how recent the last input was so that we don't do the same input 20 times
func _unhandled_input(event: InputEvent) -> void:
	# TODO: Should be able to turn off the cursor, maybe something like this:
	# if !active:
	# 	return
	
	if event is InputEventMouseMotion:
		cursor_position = event.position
	elif event is InputEventMouseButton:
		print(map_manager.grid.is_within_bounds(event.position))
