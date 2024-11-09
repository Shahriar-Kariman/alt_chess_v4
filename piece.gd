extends Node3D

@export var type: Global.PIECE_TYPE
@export var is_white: bool

var piece_mesh

var legal_moves = []

var square = {
	'column': '',
	'row': -1
}

var num_moves = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match type:
		Global.PIECE_TYPE.pawn:
			piece_mesh = load("res://peice_meshs/pawn_mesh.tscn")
		Global.PIECE_TYPE.knight:
			piece_mesh = load("res://peice_meshs/knight_mesh.tscn")
		Global.PIECE_TYPE.bishop:
			piece_mesh = load("res://peice_meshs/bishop_mesh.tscn")
		Global.PIECE_TYPE.rook:
			piece_mesh = load("res://peice_meshs/rook_mesh.tscn")
	var mesh = piece_mesh.instantiate()
	mesh.is_light = is_white
	add_child(mesh)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move_to(notation):
	Global.check_capture(notation)
	set_square(notation)
	update_position()
	num_moves = num_moves+1
	Global.game_state.is_white_turn = !Global.game_state.is_white_turn

func set_square(notation):
	square.column = notation.column
	square.row = notation.row
	update_position()

func update_position():
	var pos = Global.translate(square.column, square.row)
	position.x = pos[0]
	position.z = pos[1]

func is_on(notation):
	return Global.compare_square_notations(square, notation)

func get_legal_moves():
	match type:
		Global.PIECE_TYPE.pawn:
			legal_moves = PieceMovements.pawn(is_white, square, num_moves)
		Global.PIECE_TYPE.knight:
			legal_moves = PieceMovements.pawn(is_white, square, num_moves)
		Global.PIECE_TYPE.bishop:
			legal_moves = PieceMovements.pawn(is_white, square, num_moves)
		Global.PIECE_TYPE.rook:
			legal_moves = PieceMovements.pawn(is_white, square, num_moves)
