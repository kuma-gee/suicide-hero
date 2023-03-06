extends Node2D

@export var hitbox: HitBox2D

func set_damage(dmg: int):
    hitbox.damage = dmg