class_name Cursor extends Node2D

var cursor_cell := Vector2i.ZERO
var cursor_position := Vector2i(8, 8)

var selectable_tiles : Array[Vector2i]

@onready var map_manager = get_node("../Map Manager") as Map_Manager

signal cell_clicked(cell: Vector2i)

func _ready(): 
	$"../Unit Manager/Player Unit Manager".unit_selected.connect(_lock_cursor)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		cursor_cell = GameState.grid.get_cell(event.position)
		
		if selectable_tiles.size() > 0:
			var nearest_tile = selectable_tiles[0]
			var nearest_distance = abs(nearest_tile.x - cursor_cell.x) + abs(nearest_tile.y - cursor_cell.y)
			for tile in selectable_tiles:
				var new_distance = abs(tile.x - cursor_cell.x) + abs(tile.y - cursor_cell.y)
				if new_distance < nearest_distance:
					nearest_tile = tile
					nearest_distance = new_distance
			cursor_cell = nearest_tile
		
		cursor_position = GameState.grid.snap_to_cell(cursor_cell)
		position = cursor_position
	elif event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		cell_clicked.emit(cursor_cell)

func _lock_cursor(targeting_tiles: Array[Vector2i]):
	selectable_tiles = targeting_tiles

func disable_cursor():
	set_process_unhandled_input(false)
	$Sprite2D.visible = false

func enable_cursor():
	set_process_unhandled_input(true)
	$Sprite2D.visible = true
