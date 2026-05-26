class_name Unit_Manager extends Node

var occupied_tiles: Array[Vector2i]

@onready var enemy_manager = get_node("Enemy Unit Manager") as Enemy_Unit_Manager
@onready var player_manager = get_node("Player Unit Manager") as Player_Unit_Manager
@onready var ally_manager = get_node_or_null("Allied Unit Manager") as Allied_Unit_Manger

enum State {IDLE, UNIT_SELECTED} # TODO: I'll need more states at some point I'm sure
var state = State.IDLE

func _ready():
	var cursor = $"../Cursor"
	cursor.cell_clicked.connect(_on_cell_clicked)

# TODO: Implement _on_cell_clicked
func _on_cell_clicked(cell: Vector2i):
	match state: 
		State.IDLE:
			var unit = player_manager.get_unit_at_cell(cell)
			if unit:
				state = State.UNIT_SELECTED
				player_manager.select_unit(unit)
			else:
				# TODO: This should try to get a unit here for enemy, then ally. If neither work, should bring up the menu I think
				pass
		State.UNIT_SELECTED:
			# TODO: Cell w/ unit logic
			# Basically builds the menu that should come up, along with temporarily moving the unit
			# Cases that we need to handle here:
			#  - Spot is empty and within move range (Wait/Items)
			#  - Spot has enemy and within attack range (Attack)
			#  - Spot has speakable character and within speaking range (Talk)
			#  - Spot has player within interaction range (Trade/Rescue)
			#  - Spot has player within spell range (Heal/Teleport)
			#  - Spot is fails all above conditions (Ignore Event)
			# This would be a really great spot for one of those number enums, 
			# so that each of these menu buttons can just be an integer that we add to a number
			# Possible setup:
			# - 128 = Talk
			# - 64  = Attack
			# - 32  = Heal
			# - 16  = Teleport
			# - 8   = Rescue
			# - 4   = Trade
			# - 2   = Items
			# - 1   = Wait
			pass
	pass
