class_name DamagingItem
extends Node2D

@export var hitbox: HitBox2D

var max_hits := 3
var _hits := 0

func set_damage(dmg: int):
	hitbox.damage = dmg

func set_knockback(knockback: int):
	hitbox.knockback_force = knockback


func _on_hit_box_2d_hit():
	_hits += 1
	
	if max_hits > 0 and _hits >= max_hits:
		queue_free()
