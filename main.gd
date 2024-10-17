extends Node3D

@export var piece_template : PackedScene

var piece_list = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pawn_1 = piece_template.instantiate()
	pawn_1.type =  Global.PIECE_TYPE.pawn
	pawn_1.is_white = true
	pawn_1.set_square({ 'column':'a', 'row':2 })
	piece_list.push_front(pawn_1)
	add_child(pawn_1)

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
				square.print_notation()
				check_square(square.get_notation())

func check_square(notation):
	for i in range(piece_list.size()):
		if piece_list[i].is_on(notation):
			Global.game_state.selected = piece_list[i]
			break
		else:
			Global.game_state.selected = null
	print(Global.game_state.selected)
