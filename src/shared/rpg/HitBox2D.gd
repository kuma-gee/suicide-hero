class_name HitBox2D extends Area2D

signal hit()

export var damage := 1
export var knockback_force := 0

export var damage_over_time = false

var nodes = []

func _ready():
	connect("area_entered", self, "enter")
	connect("body_entered", self, "enter")
	connect("area_exited", self, "exit")
	connect("body_exited", self, "exit")
	
func _process(delta):
	for node in nodes:
		hit(node)


func hit(hurtbox):
	if hurtbox is HurtBox2D:
		hurtbox.damage(damage, global_position, knockback_force)
		emit_signal("hit")


func enter(node) -> void:
	if not damage_over_time:
		hit(node)
		queue_free()
		return
	
	if node is HurtBox2D:
		nodes.append(node)


func exit(node) -> void:
	if node in nodes:
		nodes.erase(node)
