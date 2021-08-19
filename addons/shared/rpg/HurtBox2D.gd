class_name HurtBox2D extends Area2D

signal damaged(dmg)
signal hit()
signal knockback(knockback)
signal invincibility_timeout()

export var invincibility_time := 0.5

var timer = Timer.new()
var invincible = false

func _ready():
	timer.one_shot = true
	timer.autostart = false
	add_child(timer)
	timer.connect("timeout", self, "_reset_invincibility")


func _reset_invincibility():
	invincible = false
	emit_signal("invincibility_timeout")


func damage(dmg: int, pos := Vector2.ZERO, knockback_force := 0) -> void:
	if invincible: return
	
	emit_signal("hit")
	emit_signal("damaged", dmg)
	if knockback_force != 0:
		var knockback_vector = pos.direction_to(global_position)
		emit_signal("knockback", knockback_vector * knockback_force)
	invincible = true
	timer.start(invincibility_time)
