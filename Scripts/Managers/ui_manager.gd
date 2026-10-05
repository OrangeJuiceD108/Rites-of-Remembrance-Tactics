class_name UI_Manager extends Control

@onready var action_menu = $"Action Menu"
@onready var inventory_menu = $"Inventory Menu"
@onready var unit_summary = $"Unit Summary"
@onready var unit_quick_info = $"Unit Quick Info"
@onready var battle_summary = $"Battle Summary"

signal action_chosen(action: Constants.ActionFlags)
signal weapon_chosen()

var state : State = State.IDLE
enum State {IDLE, ACTIONS_MENU, WEAPONS_MENU, BATTLE_PREVIEW}

func _enter_tree():
	size = get_viewport_rect().size

func _ready():
	action_menu.action_chosen.connect(_on_action_chosen)
	inventory_menu.weapon_chosen.connect(_on_weapon_chosen)

func change_state(new_state: State, kwargs: Dictionary):
	match new_state:
		State.IDLE:
			_enter_idle()
		State.ACTIONS_MENU:
			_enter_actions_menu(kwargs["actions"], kwargs["cell"])
		State.WEAPONS_MENU:
			_enter_weapons_menu(kwargs["unit"])
		State.BATTLE_PREVIEW:
			_enter_battle_preview(kwargs["attacker"])

func _enter_idle():
	# TODO: _enter_idle
	
	state = State.IDLE

func _enter_actions_menu(actions: int, cell: Vector2i):
	# TODO: _enter_actions_menu
	
	state = State.ACTIONS_MENU

func _enter_weapons_menu(unit: Unit):
	# TODO: _enter_weapons_menu
	
	state = State.WEAPONS_MENU

func _enter_battle_preview(attacker: Unit):
	# TODO: _enter_battle_preview
	
	state = State.BATTLE_PREVIEW

func update_target(unit: Unit):
	match state:
		State.IDLE:
			pass
		State.BATTLE_PREVIEW:
			pass

# --------------------------------------------------------------------------------------------------------------------------------------------------------------
# OLD CODE BELOW
# --------------------------------------------------------------------------------------------------------------------------------------------------------------

func show_actions_menu(actions: int, cell: Vector2i):
	var world_position = GameState.grid.get_loc_by_cell(cell)
	
	# FIXME: There needs to be some logic here to make the offset, 
	#        in cases where its close to the edge of the screen
	# FIXME: This should actually be in the menu class, so that it matches the rest
	var menu_offset = Vector2(16, 0)
	action_menu.position = world_position + menu_offset
	action_menu.build(actions)
	$"../Cursor".disable_cursor()
	hide_unit_quick_info()
	action_menu.visible = true

func hide_action_menu():
	$"../Cursor".enable_cursor()
	action_menu.visible = false

func show_weapons_menu(unit: Unit):
	unit_summary.build_summary(unit)
	inventory_menu.build_attack(unit.inventory)
	$"../Cursor".disable_cursor()
	hide_unit_quick_info()
	unit_summary.visible = true
	inventory_menu.visible = true

func hide_weapons_menu():
	$"../Cursor".enable_cursor()
	unit_summary.visible = false
	inventory_menu.visible = false

func show_unit_quick_info(unit: Unit):
	var direction : Vector2i
	
	var cursor_position = $"../Cursor".get_global_transform_with_canvas().get_origin()
	var viewport_size = get_viewport_rect().size
	
	if cursor_position.x / viewport_size.x < 0.5 && cursor_position.y / viewport_size.y < 0.5:
		direction = Vector2i.DOWN
	else:
		direction = Vector2i.UP
	
	unit_quick_info.shift_corner(direction)
	unit_quick_info.update_unit(unit)
	unit_quick_info.visible = true

func hide_unit_quick_info():
	unit_quick_info.visible = false

func show_battle_summary(player: Unit, enemy: Unit):
	var direction : Vector2i
	
	var cursor_position = $"../Cursor".get_global_transform_with_canvas().get_origin()
	var viewport_size = get_viewport_rect().size
	
	if cursor_position.y / viewport_size.y < 0.5:
		direction = Vector2i.RIGHT
	else:
		direction = Vector2i.LEFT
	
	battle_summary.shift_corner(direction)
	battle_summary.update_preview(player, enemy)
	battle_summary.visible = true

func hide_battle_summary():
	battle_summary.visible = false

func _on_action_chosen(action: Constants.ActionFlags):
	hide_action_menu()
	action_chosen.emit(action)

func _on_weapon_chosen():
	hide_weapons_menu()
	weapon_chosen.emit()
