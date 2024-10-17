extends Node3D

@export var type: Global.PIECE_TYPE
@export var is_white: bool

var piece_mesh

var square = {
	'column': '',
	'row': -1
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match type:
		Global.PIECE_TYPE.pawn:
			piece_mesh = load("res://peice_meshs/pawn_mesh.tscn")
	var mesh = piece_mesh.instantiate()
	mesh.is_light = is_white
	add_child(mesh)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_square(notation):
	square.column = notation.column
	square.row = notation.row
	update_position()

func update_position():
	var pos = Global.translate(square.column, square.row)
	position.x = pos[0]
	position.z = pos[1]

func is_on(notation):
	if square.column == notation.column and square.row == notation.row:
		return true
	return false
