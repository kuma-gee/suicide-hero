extends FaceCamera

export var raycast_path: NodePath
onready var raycast: RayCast = get_node(raycast_path) if raycast_path else null

func setup():
	if raycast and raycast.is_colliding():
		var collision = raycast.get_collision_point()
		look_at(collision, Vector3.UP)
	else:
		face_center()


