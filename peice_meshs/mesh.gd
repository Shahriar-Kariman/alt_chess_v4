extends MeshInstance3D

@export var is_light: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if is_light:
		material_override = preload("res://peice_meshs/white_piece_material.tres")
	else:
		material_override = preload("res://peice_meshs/white_piece_material.tres")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
