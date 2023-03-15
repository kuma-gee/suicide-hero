class_name DamagingItem
extends Node2D

@export var hitbox: PlayerHitBox

var max_hits := 3
var _hits := 0
var damage := 0
var knockback := 0

func _ready():
	hitbox.damage = damage
	hitbox.knockback_force = knockback


func _on_hit_box_2d_hit():
	_hits += 1
	
	if max_hits > 0 and _hits >= max_hits:
		queue_free()
