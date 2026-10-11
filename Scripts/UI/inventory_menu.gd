class_name Inventory_Menu extends VBoxContainer

@export var button_scene : PackedScene

signal item_chosen(item: Item, inventory: Inventory)
signal item_hovered(item: Item, inventory: Inventory)

func _ready():
	var anchors = Constants.get_anchors_for_corner(self, Vector2i.UP + Vector2i.LEFT)
	anchor_top = anchors[Vector2i.UP]
	anchor_bottom = anchors[Vector2i.DOWN]
	anchor_left = anchors[Vector2i.LEFT]
	anchor_right = anchors[Vector2i.RIGHT]

func show_element(items: Array[Item], inventory: Inventory):
	for child in get_children():
		child.queue_free()
	
	for item in items:
		_add_item_button(item, inventory)
	
	# WARNING: CURSOR SCREWING TEMPORARY
	%"Cursor".disable_cursor()
	visible = true

func _add_item_button(item: Item, inventory: Inventory):
	var button = button_scene.instantiate()
	button.get_node("Name").text = item.item_name
	if item.breakable:
		button.get_node("Durability").text = str(item.durability)
	else:
		button.get_node("Durability").text = ""
	button.pressed.connect(func(): item_chosen.emit(item, inventory))
	button.mouse_entered.connect(func(): item_hovered.emit(item, inventory))
	add_child(button)

func hide_element():
	# WARNING: CURSOR SCREWING TEMPORARY
	%"Cursor".enable_cursor()
	visible = false
