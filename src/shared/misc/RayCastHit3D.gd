class_name RayCastHit3D extends RayCast

export var damage = 1

func activate():
	if is_colliding() and get_collider() is HurtBox3D:
		get_collider().damage(damage, get_collision_point())
