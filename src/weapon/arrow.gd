extends CharacterBody2D

@export var speed := 500
@export var hitbox: HitBox2D

var pierce = false

func set_damage(dmg: int):
	hitbox.damage = dmg

func set_knockback(force: int):
	hitbox.knockback_force = force

func _process(delta):
	velocity = Vector2.RIGHT.rotated(global_rotation) * speed
	move_and_slide()


func _on_hit_box_2d_hit():
	if not pierce:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
