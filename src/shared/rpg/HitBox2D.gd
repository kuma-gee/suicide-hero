class_name HitBox2D extends Area2D

signal hit()

@export var damage := 1
@export var knockback_force := 0

var nodes = []

func _ready():
	var _x = connect("area_entered", enter)
	var _y = connect("body_entered", enter)

func enter(node) -> void:
	if node is HurtBox2D:
		node.damage(damage, global_position, knockback_force)
		hit.emit()
