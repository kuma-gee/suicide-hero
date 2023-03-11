class_name KnifeCircle
extends Node2D

@export var timer: Timer
@export var knife: PackedScene

@export var player: Player = owner

@onready var _initial_child_count = get_child_count()

var _knifes: Array[Node2D] = []
var _logger = Logger.new("KnifeCircle")
var _res: KnifeUpgradeResource

func apply(res: KnifeUpgradeResource):
	_res = res
	_spawn_knifes()
	_logger.debug("Upgrading Knife Circle")

func _has_no_knifes():
	return get_child_count() == _initial_child_count

func _despawn_knifes():
	for knife in _knifes:
		knife.queue_free()

func _spawn_knifes() -> void:
	_despawn_knifes()

	var angle_step = TAU / _res.amount
	var dir = Vector2.UP
	for i in range(0, _res.amount):
		var node = knife.instantiate()
		var offset = dir * _res.offset
		var angle = angle_step * i
		node.position += offset.rotated(angle)
		node.rotation = angle_step * i
		node.max_hits = _res.max_hits
		node.damage = _res.damage * player.get_attack_multiplier()
		node.knockback = _res.knockback
		node.scale = Vector2(_res.scale, _res.scale)
		add_child(node)
	
	timer.stop()
	_logger.debug("Spawning %s knifes in angle of %s" % [_res.amount, rad_to_deg(angle_step)])

func _process(_delta):
	if _res == null: return
	
	if _has_no_knifes() and timer.is_stopped(): 
		timer.start(_res.respawn_time)
		_logger.debug("Start countdown for new knifes: %ss" % _res.respawn_time)
	else:
		global_rotation += TAU * _delta * _res.speed

func _on_timer_timeout():
	_spawn_knifes()
