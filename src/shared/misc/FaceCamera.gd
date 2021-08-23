class_name FaceCamera extends Spatial

func _ready():
	face_center()

func face_center():
	var center = get_viewport().size / 2
	var world_center = get_viewport().get_camera().project_position(center, 1000)
	look_at(world_center * -1, Vector3.UP)
