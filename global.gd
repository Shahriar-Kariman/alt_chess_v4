extends Node

func translate(column, row):
	var x = -('a'.unicode_at(0)-column.unicode_at(0)+4) + 0.5
	var z = -(row-4) + 0.5
	return [x,z]

enum PIECE_TYPE {
	pawn,
}

var piece_list = []

var game_state = {
	'is_white_turn': true,
	'selected_piece': null
}

func check_square(notation):
	for i in range(Global.piece_list.size()):
		if Global.piece_list[i].is_on(notation):
			return Global.piece_list[i]
	return null

func compare_square_notations(notation_1, notation_2):
	if notation_1.column==notation_2.column and notation_1.row==notation_2.row:
		return true
	return false
