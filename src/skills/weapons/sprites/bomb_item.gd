extends ThrowBody

@export var hitbox: PlayerHitBox
@export var explosion_timer: Timer
@export var collision: CollisionShape2D
@export var anim: AnimationPlayer

var radius := 0
var damage := 0

func _ready():
	hitbox.damage = damage
	collision.shape.radius = radius
	collision.disabled = true

	explosion_timer.timeout.connect(_explode)
	explosion_timer.start()
	super._ready()

func _explode():
	anim.play("explode")


func _on_animation_player_animation_finished(anim_name):
	queue_free()
