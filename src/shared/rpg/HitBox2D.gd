class_name HitBox2D extends Area2D

signal hit()

@export var damage := 1
@export var knockback_force := 0

@export var damage_over_time = false

var nodes = []

func _ready():
	var _x = connect("area_entered", enter)
	var _y = connect("body_entered", enter)
	var _z = connect("area_exited", exit)
	var _c = connect("body_exited", exit)
	
func _process(_delta):
	for node in nodes:
		hit_hurtbox(node)


func hit_hurtbox(hurtbox):
	if hurtbox is HurtBox2D:
		hurtbox.damage(damage, global_position, knockback_force)
		emit_signal("hit")


func enter(node) -> void:
	if not damage_over_time:
		hit_hurtbox(node)
		queue_free()
		return
	
	if node is HurtBox2D:
		nodes.append(node)


func exit(node) -> void:
	if node in nodes:
		nodes.erase(node)
