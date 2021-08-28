class_name Enemy extends KinematicBody2D

export(HealthDrop.Size) var heal_size := HealthDrop.Size.SMALL
export var health_drop: PackedScene
export var enemy_value = 1
export var keep_distance = 0

onready var health := $Health

onready var state_machine := $StateMachine
onready var move := $StateMachine/Move2D
onready var knockback_state := $StateMachine/Knockback2D
onready var sprite := $Body/Sprite

var player: Node2D

func _process(_delta):
	if player:
		var distance := global_position.distance_to(player.global_position)
		if distance <= keep_distance:
			if distance <= keep_distance - 10:
				move.motion = player.global_position.direction_to(global_position).normalized()
			else:
				move.motion = Vector2.ZERO
		else:
			move.motion = global_position.direction_to(player.global_position).normalized()
		move.look_dir = move.motion

func _on_HurtBox_damaged(dmg):
	health.reduce(dmg)


func _on_Health_zero_value():
	call_deferred("_spawn_health_drop")
	queue_free()

func _spawn_health_drop():
	if health_drop != null:
		var drop: HealthDrop = health_drop.instance()
		drop.heal_size = heal_size
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
