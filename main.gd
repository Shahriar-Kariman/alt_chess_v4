extends Node3D

@export var piece_template : PackedScene

var piece_list = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pawn_1 = piece_template.instantiate()
	pawn_1.type =  Global.PIECE_TYPE.pawn
	pawn_1.is_white = true
	pawn_1.set_square({ 'column':'a', 'row':2 })
	add_child(pawn_1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
