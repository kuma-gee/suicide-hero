class_name HitBox2D extends Area2D

signal hit()

@export var damage := 1
@export var knockback_force := 0

var nodes = []

func _ready():
	area_entered.connect(enter)
	body_entered.connect(enter)
	area_exited.connect(exit)
	body_exited.connect(exit)


func enter(node) -> void:
	if node is HurtBox2D:
		nodes.append(node)

func exit(node) -> void:
	if node in nodes:
		nodes.erase(node)

func _process(delta):
	for node in nodes:
		if node.damage(damage, global_position, knockback_force):
			hit.emit()
