class_name Unit_Quick_Info extends PanelContainer

@onready var unit_name_label := $"HBoxContainer/VBoxContainer/Unit Name"
@onready var current_hp_label := $"HBoxContainer/VBoxContainer/HBoxContainer/Current HP"
@onready var max_hp_label := $"HBoxContainer/VBoxContainer/HBoxContainer/Max HP"
@onready var health_bar := $"HBoxContainer/VBoxContainer/ProgressBar"
@onready var portrait := $"HBoxContainer/Portrait"

func show_element(unit: Unit):
	var direction : Vector2i
	
	var cursor_position = %"Cursor".get_global_transform_with_canvas().get_origin()
	var viewport_size = get_viewport_rect().size
	
	if cursor_position.x / viewport_size.x < 0.5 && cursor_position.y / viewport_size.y < 0.5:
		direction = Vector2i.DOWN
	else:
		direction = Vector2i.UP
	
	_shift_corner(direction)
	_update_unit(unit)
	visible = true

func hide_element():
	visible = false

func _update_unit(unit: Unit):
	unit_name_label.text = unit.name
	
	current_hp_label.text = str(unit.hp)
	max_hp_label.text = str(unit.stats[Constants.Stat.HP])
	
	health_bar.value = unit.hp
	health_bar.max_value = unit.stats[Constants.Stat.HP]
	
	# TODO: UPDATE PORTRAIT

func _shift_corner(loc: Vector2i):
	if loc != Vector2i.UP && loc != Vector2i.DOWN:
		push_error("Incorrect shift params for Unit Quick Info")
	
	var anchors = Constants.get_anchors_for_corner(self, loc + Vector2i.LEFT)
	anchor_top = anchors[Vector2i.UP]
	anchor_bottom = anchors[Vector2i.DOWN]
	anchor_left = anchors[Vector2i.LEFT]
	anchor_right = anchors[Vector2i.RIGHT]
	
	offset_top = 0
	offset_bottom = 0
	offset_left = 0
	offset_right = 0
