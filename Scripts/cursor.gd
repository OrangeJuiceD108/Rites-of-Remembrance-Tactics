class_name Cursor extends Node2D

var cursor_cell := Vector2i.ZERO
var cursor_position := Vector2i(8, 8)

@onready var map_manager = get_node("../Map Manager") as Map_Manager

signal cell_clicked(cell: Vector2i)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor_cell = GameState.grid.get_cell(event.position)
		cursor_position = GameState.grid.snap_to_cell(cursor_cell)
		position = cursor_position
	elif event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		cell_clicked.emit(cursor_cell)

func disable_cursor():
	set_process_unhandled_input(false)
	$Sprite2D.visible = false

func enable_cursor():
	set_process_unhandled_input(true)
	$Sprite2D.visible = true
