extends Node3D

@export var piece_template : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.server_hand_shake()
	for p in Global.initial_piece_state:
		var piece = piece_template.instantiate()
		piece.type =  p.type
		piece.is_white = p.is_white
		piece.set_square(p.square)
		Global.piece_list.push_front(piece)
		add_child(piece)

var rayOrigin = Vector3()
var rayEnd = Vector3()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# ray casting
	if Input.is_action_just_pressed("click"):
		var space_state = get_world_3d().direct_space_state
		var mouse_position = get_viewport().get_mouse_position()
		rayOrigin = $Camera3D.project_ray_origin(mouse_position)
		rayEnd = rayOrigin + $Camera3D.project_ray_normal(mouse_position) * 1000
		var ray_query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
		var intersection = space_state.intersect_ray(ray_query)
		
		if intersection:
			var square = intersection["collider"].get_parent().get_parent()
			if square.is_in_group("square"):
				#square.print_notation()
				if Global.game_state.selected_piece:
					var legal_moves = Global.game_state.selected_piece.legal_moves
					#print(legal_moves)
					if is_legal(square.get_notation(), legal_moves):
						Global.game_state.selected_piece.move_to(square.get_notation())
				var piece = Global.check_square(square.get_notation())
				if piece and Global.game_state.is_white_turn == piece.is_white:
					Global.game_state.selected_piece = piece
					piece.get_legal_moves()
				else:
					Global.game_state.selected_piece = null

func is_legal(square, legal_moves):
	for m in legal_moves:
		if Global.compare_square_notations(m, square):
			return true
	return false
