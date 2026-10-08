class_name Action_Menu extends VBoxContainer

@export var button_scene : PackedScene

signal action_chosen(action: Constants.ActionFlags)

func show_element(actions: int, cell: Vector2i):
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

func _build(actions: int):
	for child in get_children():
		child.queue_free()
	
	if actions & Constants.ActionFlags.TALK:
		_add_button("Talk", Constants.ActionFlags.TALK)
	if actions & Constants.ActionFlags.ATTACK:
		_add_button("Attack", Constants.ActionFlags.ATTACK)
	if actions & Constants.ActionFlags.HEAL:
		_add_button("Heal", Constants.ActionFlags.HEAL)
	if actions & Constants.ActionFlags.TELEPORT:
		_add_button("Teleport", Constants.ActionFlags.TELEPORT)
	if actions & Constants.ActionFlags.RESCUE:
		_add_button("Rescue", Constants.ActionFlags.RESCUE)
	if actions & Constants.ActionFlags.TRADE:
		_add_button("Trade", Constants.ActionFlags.TRADE)
	
	_add_button("Items", Constants.ActionFlags.ITEMS)
	_add_button("Wait", Constants.ActionFlags.WAIT)

func _add_button(label: String, flag: int):
	var button = button_scene.instantiate()
	button.text = label
	button.pressed.connect(func(): action_chosen.emit(flag))
	add_child(button)
