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
	var mesh = piece_mesh.instantiate()
	mesh.is_light = is_white
	add_child(mesh)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func move_to(notation):
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
	var direction = 1
	if !is_white:
		direction = -1
	var col = square.column.unicode_at(0)
	var r = square.row
	var squares = []
	# the square in front of the pawn
	var notation = { 'column':String.chr(col), 'row':r+direction*1 }
	var piece = Global.check_square(notation)
	if !piece:
		squares.push_front(notation)
		# the two squares where the pawn goes to capture things
	var a = 1
	for i in range(2):
		notation = { 'column':String.chr(col+a), 'row':r+direction*1 }
		piece = Global.check_square(notation)
		if piece and piece.is_white != is_white:
			squares.push_front(notation)
		a = -1
	# the first move can go up to another row
	if num_moves==0:
		notation = { 'column':String.chr(col), 'row':r+direction*2 }
		piece = Global.check_square(notation)
		if !piece:
			squares.push_front(notation)
	legal_moves = squares
