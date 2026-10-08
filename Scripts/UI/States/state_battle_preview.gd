class_name State_Battle_Preview extends UI_State

@onready var battle_summary : Battle_Summary = %"UI Manager/Battle Summary"
var player : Unit

func _init():
	state = State.BATTLE_PREVIEW

func enter(kwargs: Dictionary):
	player = kwargs["player"]

func exit():
	battle_summary.hide_element()

func update_target_cell(cell: Vector2i):
	var enemy = %"Unit Manager".get_unit_at_cell(cell)
	
	if enemy == null:
		push_error("Unit is null somehow")
	
	battle_summary.show_element(player, enemy)
