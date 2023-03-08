extends ThrowBody

@export var hitbox: HitBox2D

var knockback := 0

func _ready():
	hitbox.knockback_force = knockback
