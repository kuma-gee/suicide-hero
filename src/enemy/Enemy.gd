class_name Enemy extends CharacterBody2D

@export var heal_size := HealthDrop.Size.SMALL
@export var health_drop: PackedScene
@export var enemy_value = 1
@export var soft_collision_multiplier := 400

@onready var health := $Health

@onready var state_machine := $StateMachine
@onready var move := $StateMachine/Move2D
@onready var knockback_state := $StateMachine/Knockback2D

@onready var sprite: AnimatedSprite2D = $Body/AnimatedSprite2D 
@onready var hitbox: HitBox2D = $HitBox

var player: Node2D
var resource: EnemyResource

func _ready():
	if resource:
		sprite.sprite_frames = resource.sprites
		health.max_value = resource.health
		hitbox.damage = resource.attack
		move.speed = resource.speed
		sprite.play("default")
	

func _process(delta):
	if player:
		move.motion = global_position.direction_to(player.global_position)
		
		var distance := global_position.distance_to(player.global_position)
		if distance < 10 and move.motion.length() > 0.5:
			move.motion /= 2
		
		move.look_dir = move.motion

func _on_HurtBox_damaged(dmg):
	print("Enemy hit: %s / %s -> %s" % [health.value, health.max_value, health.value - dmg])
	health.reduce(dmg)


func _on_Health_zero_value():
	call_deferred("_spawn_health_drop")
	queue_free()

func _spawn_health_drop():
	if health_drop != null:
		var drop: HealthDrop = health_drop.instantiate()
		drop.heal_size = heal_size
		get_tree().current_scene.add_child(drop)
		drop.global_position = global_position


func _on_HurtBox_knockback(knockback):
	state_machine.transition(knockback_state, {"knockback": knockback})


func _on_knockback_2d_knockback_finished():
	state_machine.transition(move)
