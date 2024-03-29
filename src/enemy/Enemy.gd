class_name Enemy extends CharacterBody2D

signal died()

@export var health_drop_chance := 0.5
@export var health_drop: PackedScene

@export var enemy_value = 1
@export var soft_collision_multiplier := 400
@export var hit_label: PackedScene

@onready var health := $Health

@onready var state_machine := $StateMachine
@onready var move := $StateMachine/Move2D
@onready var knockback_state := $StateMachine/Knockback2D

@onready var sprite: AnimatedSprite2D = $Body/AnimatedSprite2D 
@onready var hitbox: HitBox2D = $HitBox
@onready var debuffer: Debuffer = $Debuffer

var player: Node2D
var resource: EnemyResource

var _logger = Logger.new("Enemy")

func _ready():
	debuffer.debuff_changed.connect(_update_debuffer)

	if resource:
		sprite.sprite_frames = resource.sprites
		health.max_value = resource.health
		hitbox.damage = resource.attack
		move.speed = resource.speed
		scale = Vector2(resource.scale, resource.scale)
		sprite.play("default")
	else:
		_logger.warn("No enemy resource for %s " % self)

func _update_debuffer():
	move.speed = resource.speed * debuffer.get_movement_multiplier()
	# TODO: show icon if debuff active
	

func _process(delta):
	if player:
		move.motion = global_position.direction_to(player.global_position)
		
		var distance := global_position.distance_to(player.global_position)
		if distance < 10 and move.motion.length() > 0.5:
			move.motion /= 2
		
		move.look_dir = move.motion

func _on_HurtBox_damaged(dmg, is_crit):
	health.reduce(dmg)

	if dmg > 0:
		EffectManager.show_hit(dmg, is_crit, global_position)


func _on_Health_zero_value():
	call_deferred("_maybe_drop_item")
	died.emit()
	queue_free()

func _maybe_drop_item():
	var rand = randf()

	if rand <= health_drop_chance:
		var drop: HealthDrop = health_drop.instantiate()
		drop.global_position = global_position
		get_tree().current_scene.add_child(drop)


func _on_HurtBox_knockback(knockback):
	state_machine.transition(knockback_state, {"knockback": knockback})


func _on_knockback_2d_knockback_finished():
	state_machine.transition(move)
