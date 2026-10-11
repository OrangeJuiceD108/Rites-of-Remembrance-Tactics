class_name Enemy_Registry extends Resource

@export var pairs: Array[Hostile_Pair]

var _lookup: Dictionary = {}
var _built := false

func are_hostile(one: Faction, two: Faction) -> bool:
	if one == two:
		return false
	if not _built:
		_build_lookup()
	return _lookup.get(one, {}).has(two)

func _build_lookup() -> void:
	_lookup.clear()
	for pair in pairs:
		if pair == null or pair.a == null or pair.b == null:
			push_error("Incomplete HostilePair in Enemy_Registry")
			continue
		_add(pair.a, pair.b)
		_add(pair.b, pair.a)
	_built = true

func _add(from: Faction, to: Faction) -> void:
	if not _lookup.has(from):
		_lookup[from] = {}
	_lookup[from][to] = true
