class_name PlayerHitBox
extends Area2D

signal hit()

@export var damage := 1
@export var knockback_force := 0
@export var crit_multipler := 2.0

var player: Player

func _ready():
	player = get_tree().get_first_node_in_group("Player")
	area_entered.connect(enter)
	body_entered.connect(enter)

func enter(node) -> void:
	if node is HurtBox2D:
		_hit(node)

func _hit(hurtbox: HurtBox2D):
	var dmg = damage * player.get_attack_multiplier()
	if randf() <= player.get_crit_chance():
		dmg *= crit_multiplier

	hurtbox.damage(dmg, global_position, knockback_force)
	hit.emit()