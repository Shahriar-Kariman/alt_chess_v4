extends Node

func translate(column, row):
	var x = -('a'.unicode_at(0)-column.unicode_at(0)+4) + 0.5
	var z = -(row-4) + 0.5
	return [x,z]

enum PIECE_TYPE {
	pawn,
}

var game_state = {
	'is_white_turn': true,
	'selected_piece': null
}
