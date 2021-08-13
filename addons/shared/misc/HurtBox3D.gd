class_name HurtBox3D extends Area

signal hit(pos)

export var invincibility_time = 1

var timer = Timer.new()
var invincible = false

func _ready():
	add_child(timer)
	timer.connect("timeout", self, "_reset_invincibility")

func _reset_invincibility():
	invincible = false

func damage(dmg: int, pos: Vector3 = Vector3.ZERO) -> void:
	if invincible: return
	
	emit_signal("hit", pos)
	invincible = true
	timer.start(invincibility_time)
