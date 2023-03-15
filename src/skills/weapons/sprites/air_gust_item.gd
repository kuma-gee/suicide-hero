extends ThrowBody

@export var hitbox: PlayerHitBox

var knockback := 0

func _ready():
	hitbox.knockback_force = knockback
	global_rotation = Vector2.UP.angle_to(dir)
	
	stopped.connect(func(): queue_free())
	
	super._ready()
