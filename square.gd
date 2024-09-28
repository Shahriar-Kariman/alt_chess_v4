extends Node3D

@export var isWhite: bool

var notation = {
	'column': '',
	'row': -1
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("square")
	if isWhite:
		$MeshInstance3D.material_override = preload("res://white_square_material.tres")
	else:
		$MeshInstance3D.material_override = preload("res://black_square_material.tres")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func  set_notation(col, r):
	notation.column = col
	notation.row = r

func print_notation():
	print(notation.column, notation.row)
