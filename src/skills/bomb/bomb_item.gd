extends ThrowBody

@export var hitbox: HitBox2D
@export var explosion_timer: Timer

var radius := 0
var damage := 0

func _ready():
	hitbox.damage = damage

	var collision = hitbox.$CollisionShape2D
	collision.shape.radius = radius

	explosion_timer.timeout.connect(_explode)
	explosion_timer.start()

func _explode():
	pass # TOD