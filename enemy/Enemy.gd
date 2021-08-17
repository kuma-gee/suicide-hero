extends KinematicBody2D

export var health_drop: PackedScene
export var enemy_value = 1

onready var health := $Health

onready var state_machine := $StateMachine
onready var move := $StateMachine/Move2D
onready var knockback_state := $StateMachine/Knockback2D
onready var sprite := $Body/Sprite

var player: Node2D

func _process(delta):
	if player:
		move.motion = global_position.direction_to(player.global_position).normalized()
		move.look_dir = move.motion

func _on_HurtBox_damaged(dmg):
	health.reduce(dmg)


func _on_Health_zero_value():
	call_deferred("_spawn_health_drop")
	queue_free()

func _spawn_health_drop():
	var drop = health_drop.instance()
	get_tree().current_scene.add_child(drop)
	drop.global_position = global_position


func _on_HurtBox_knockback(knockback):
	state_machine.transition(knockback_state, {"knockback": knockback})


func _on_Knockback2D_knockback_finished():
	state_machine.transition(move)


func _on_HurtBox_invincibility_timeout():
	sprite.modulate.a8 = 255


func _on_HurtBox_hit():
	sprite.modulate.a8 = 180
