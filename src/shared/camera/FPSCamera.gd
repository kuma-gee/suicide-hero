extends Spatial

export var mouse_sensitivity = 0.1
export var enable = true

export var body_path: NodePath
onready var body := get_node(body_path) if body_path else get_parent()

func _input(event):
	if enable and event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		self.rotate_x(deg2rad(event.relative.y * mouse_sensitivity))
		body.rotate_y(deg2rad(event.relative.x * mouse_sensitivity * -1))

		var camera_rot = rotation_degrees
		camera_rot.x = clamp(camera_rot.x, -70, 70)
		rotation_degrees = camera_rot
