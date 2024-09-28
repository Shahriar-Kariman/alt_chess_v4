extends Node3D

@export var square_template: PackedScene

@export var camera: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Generate the board
	var isStartLight = false
	for col in 8:
		var column = char(col+97)
		var isLight = isStartLight
		for r in 8:
			var row = r+1
			var s = square_template.instantiate()
			s.isWhite = isLight
			var coor = Global.translate(column,row)
			s.position.x = coor[0]
			s.position.z = coor[1]
			s.set_notation(column,row)
			isLight = !isLight
			add_child(s)
		isStartLight = !isStartLight

var rayOrigin = Vector3()
var rayEnd = Vector3()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# ray casting
	if Input.is_action_just_pressed("click"):
		var space_state = get_world_3d().direct_space_state
		var mouse_position = get_viewport().get_mouse_position()
		rayOrigin = camera.project_ray_origin(mouse_position)
		rayEnd = rayOrigin + camera.project_ray_normal(mouse_position) * 1000
		var ray_query = PhysicsRayQueryParameters3D.create(rayOrigin, rayEnd)
		var intersection = space_state.intersect_ray(ray_query)
		
		if intersection:
			var square = intersection["collider"].get_parent().get_parent()
			if square.is_in_group("square"):
				square.print_notation()
