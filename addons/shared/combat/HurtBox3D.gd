class_name HurtBox3D extends Area

signal damaged(dmg)
signal hit(pos)
signal knockback(knockback)

export var invincibility_time = 1

var timer = Timer.new()
var invincible = false

func _ready():
	add_child(timer)
	timer.connect("timeout", self, "_reset_invincibility")

func _reset_invincibility():
	invincible = false

func damage(dmg: int, pos := Vector3.ZERO, knockback_force := 0) -> void:
	if invincible: return
	
	emit_signal("hit", pos)
	emit_signal("damaged", dmg)
	if knockback_force != 0:
		var knockback_vector = pos.direction_to(global_transform.origin)
		emit_signal("knockback", knockback_vector * knockback_force)
	invincible = true
	timer.start(invincibility_time)
