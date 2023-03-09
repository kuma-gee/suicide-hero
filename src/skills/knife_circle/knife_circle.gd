class_name KnifeCircle
extends Node2D

@export var timer: Timer
@export var knife: PackedScene
@export var upgrader: Upgrader

@export var player: Player = owner

@onready var _initial_child_count = get_child_count()

var _logger = Logger.new("KnifeCircle")

func get_upgrade():
	return upgrader.get_next_upgrade()

func apply(r: UpgradeResource):
	var upgrade = r as KnifeUpgradeResource
	if upgrade :
		upgrader.upgrade()
		_spawn_knifes()
		_logger.debug("Upgrading Knife Circle")

func _has_no_knifes():
	return get_child_count() == _initial_child_count

func _spawn_knifes() -> void:
	var res = upgrader.resource as KnifeUpgradeResource
	if not _has_no_knifes() or res == null: return

	var angle_step = TAU / res.amount
	var dir = Vector2.UP
	for i in range(0, res.amount):
		var node = knife.instantiate()
		var offset = dir * res.offset
		var angle = angle_step * i
		node.position += offset.rotated(angle)
		node.rotation = angle_step * i
		node.max_hits = res.max_hits
		node.damage = res.damage * player.get_attack_multiplier()
		node.knockback = res.knockback
		node.scale = Vector2(res.scale, res.scale)
		add_child(node)
	
	_logger.debug("Spawning %s knifes in angle of %s" % [res.amount, rad_to_deg(angle_step)])

func _process(_delta):
	var res = upgrader.resource as KnifeUpgradeResource
	if res == null: return
	
	if _has_no_knifes() and timer.is_stopped(): 
		timer.start(res.respawn_time)
		_logger.debug("Start countdown for new knifes: %ss" % res.respawn_time)
	else:
		global_rotation += TAU * _delta * res.speed

func _on_timer_timeout():
	_spawn_knifes()
