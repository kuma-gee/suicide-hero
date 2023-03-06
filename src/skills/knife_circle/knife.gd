extends Node2D

@export var hitbox: HitBox2D

var max_hits := 3
var _hits := 0

func set_damage(dmg: int, knockback: int):
	hitbox.damage = dmg
	hitbox.knockback_force = knockback


func _on_hit_box_2d_hit():
	_hits += 1
	
	if _hits >= max_hits:
		queue_free()
