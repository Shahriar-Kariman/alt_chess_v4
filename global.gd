extends Node

func translate(column, row):
	var x = -('a'.unicode_at(0)-column.unicode_at(0)+4)
	var z = -(row-4)
	return [x,z]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
