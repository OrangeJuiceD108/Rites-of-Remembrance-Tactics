class_name Attack extends Action

func _init():
	type = Type.ATTACK
	action_name = "Attack"

func is_available() -> bool:
	# TODO: Check to see if the Unit has any weapons
	
	for cell in controller.staged_attack_cells:
		var unit = %"Unit Manager".get_unit_at_cell(cell)
		if unit != null && %"Unit Manager".are_hostile(controller.selected_unit, unit):
			return true
	return false

func action_selected():
	%"UI Manager".item_chosen.connect(_weapon_selected, CONNECT_ONE_SHOT)
	%"UI Manager".item_hovered.connect(_weapon_hovered)
	
	controller.selected_action = self
	
	var kwargs = {
		"unit": controller.selected_unit,
		"items": controller.selected_unit.inventory.get_items_with_component(Weapon_Component)
		}
	controller.change_state(Player_Turn_State.State.SELECTING_ITEM, kwargs)

func _weapon_selected(item: Item, inventory: Inventory):
	inventory.equip(item)
	controller.change_state(Player_Turn_State.State.TARGETING, {})
	%"UI Manager".item_hovered.disconnect(_weapon_hovered)

func _weapon_hovered(item: Item, inventory: Inventory):
	inventory.equip(item)

func on_targeting():
	var kwargs = {"player": controller.selected_unit}
	%"UI Manager".change_state(UI_State.State.BATTLE_PREVIEW, kwargs)

func get_targetable_cells():
	var cells : Array[Vector2i]
	for cell in controller.staged_attack_cells:
		var unit = %"Unit Manager".get_unit_at_cell(cell)
		if unit != null && %"Unit Manager".are_hostile(controller.selected_unit, unit):
			cells.append(cell)
	return cells

func confirm_cell(cell: Vector2i):
	var target = %"Unit Manager".get_unit_at_cell(cell)
	if target == null || !%"Unit Manager".enemy_registry.are_hostile(controller.faction, target.faction):
		push_error("Impossible target")
	
	Battle_Simulator.run_battle(controller.selected_unit, target)
	
	controller.confirm_move()
	controller.change_state(Player_Turn_State.State.IDLE, {})
	# TODO: Exhaust unit

func backtrack():
	pass

func cancel():
	controller.selected_action = null
	if %"UI Manager".item_chosen.is_connected(_weapon_selected):
		%"UI Manager".item_chosen.disconnect(_weapon_selected)
	if %"UI Manager".item_hovered.is_connected(_weapon_hovered):
		%"UI Manager".item_hovered.disconnect(_weapon_hovered)
