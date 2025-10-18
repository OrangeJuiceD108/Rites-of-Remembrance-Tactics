class_name Cursor extends Node


var cursor_position := Vector2.ZERO


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor_position = event.position
	elif event is InputEventMouseButton:
		# TODO: Stuff happens here
		pass
