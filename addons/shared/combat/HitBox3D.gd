class_name HitBox3D extends Area

export var damage = 1

func _ready():
	connect("area_entered", self, "hit")
	connect("body_entered", self, "hit")

func hit(hurtbox):
	if hurtbox is HurtBox3D:
		hurtbox.damage(damage, global_transform.origin)
	queue_free()
