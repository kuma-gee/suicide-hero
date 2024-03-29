class_name HurtBox2D extends Area2D

signal damaged(dmg, is_crit)
signal hit()
signal knockback(knockback)
signal invincibility_timeout()

@export var invincibility_time := 0.0

var timer = Timer.new()
var invincible = false

func _ready():
	timer.one_shot = true
	timer.autostart = false
	add_child(timer)
	timer.connect("timeout", _reset_invincibility)


func _reset_invincibility():
	invincible = false
	emit_signal("invincibility_timeout")


func damage(dmg: int, pos := Vector2.ZERO, knockback_force := 0, is_crit := false) -> bool:
	if invincible:
		return false
	
	hit.emit()
	damaged.emit(dmg, is_crit)
	if knockback_force != 0:
		var knockback_vector = pos.direction_to(global_position)
		knockback.emit(knockback_vector * knockback_force)
	
	if invincibility_time > 0:
		invincible = true
		timer.start(invincibility_time)
	return true
