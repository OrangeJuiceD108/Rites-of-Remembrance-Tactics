class_name Cursor extends Node2D

#var active := true

var cursor_cell := Vector2.ZERO
var cursor_position := Vector2(8, 8)

@onready var map_manager = get_node("../Map Manager") as Map_Manager
@onready var grid = map_manager.grid

# TODO: Needs to check how recent the last input was so that we don't do the same input 20 times
func _unhandled_input(event: InputEvent) -> void:
	# TODO: Should be able to turn off the cursor, maybe something like this:
	#if !active:
		#return
	# This might not work because this stops all input events, not just mouse
	
	if event is InputEventMouseMotion:
		cursor_cell = grid.get_cell(event.position)
		cursor_position = grid.snap_to_cell(cursor_cell)
		position = cursor_position
	elif event is InputEventMouseButton && event.pressed:
		print(cursor_cell)
		# Below is for testing
		var move_rad = get_node("../Unit Manager").get_move_radius(cursor_cell)
		for spot in move_rad:
			continue
