extends Node3D

@export var is_light: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var direction = Vector3(1, 0, 0)
	for child in get_children():
		if is_light:
			child.material_override = preload("res://peice_meshs/white_piece_material.tres")
			child.rotation_degrees.y -= 90
		else:
			child.material_override = preload("res://peice_meshs/black_piece_material.tres")
			child.rotation_degrees.y += 90

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
