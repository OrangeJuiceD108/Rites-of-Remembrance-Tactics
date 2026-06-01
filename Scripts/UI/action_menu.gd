class_name Action_Menu extends VBoxContainer

@export var button_scene : PackedScene

signal action_chosen(action: Constants.ActionFlags)

func _ready():
	set_anchors_preset(Control.PRESET_TOP_LEFT)

func build(actions: int):
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
