class_name Action_Menu extends VBoxContainer

signal action_chosen(action: Constants.ActionFlags)

# TODO: Finish build
func build(actions: int):
	for child in get_children():
		child.queue_free()
	_add_button("Wait", Constants.ActionFlags.WAIT)
	_add_button("Items", Constants.ActionFlags.ITEMS)
	
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

# TODO: Finish _add_button
func _add_button(label: String, flag: int):
	var button = Button.new()
	button.text = label
	button.pressed.connect(func(): action_chosen.emit(flag))
	add_child(button)
