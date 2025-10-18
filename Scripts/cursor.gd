extends Node

var cursor_position := Vector2.ZERO

# TODO: Function to get mouse input
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor_position = event.position
	elif event is InputEventMouseButton:
		# TODO: Stuff happens here
		pass
