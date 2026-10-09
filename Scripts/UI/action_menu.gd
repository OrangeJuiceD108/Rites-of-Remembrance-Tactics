class_name Action_Menu extends VBoxContainer

@export var button_scene : PackedScene

func show_element(actions: Array[Action], cell: Vector2i):
	var world_position = GameState.grid.get_loc_by_cell(cell)
	
	# FIXME: There needs to be some logic here to make the offset, 
	#        in cases where its close to the edge of the screen
	# FIXME: This should actually be in the menu class, so that it matches the rest
	var menu_offset = Vector2(16, 0)
	position = world_position + menu_offset
	_build(actions)
	# WARNING: TEMPORARY CURSOR SCREWING
	%"Cursor".disable_cursor()
	visible = true

func hide_element():
	# WARNING: TEMPORARY CURSOR SCREWING
	%"Cursor".enable_cursor()
	visible = false

func _build(actions: Array[Action]):
	for child in get_children():
		child.queue_free()
	for action in actions:
		_add_button(action)

func _add_button(action: Action):
	var button = button_scene.instantiate()
	button.text = action.action_name
	button.pressed.connect(action.action_selected)
	add_child(button)
