class_name KnifeCircle
extends Skill

@export var timer: Timer
@export var knife: PackedScene

@export var res: KnifeUpgradeResource

var _is_spawned = false
var _waiting_timer = false

func apply(res: UpgradeResource):
	var upgrade = res as KnifeUpgradeResource
	if upgrade :
        res = upgrade

func activate(player: PlayerResource) -> void:
    if _is_spawned or res == null: return

    _is_spawned = true

    var angle_step = TAU / res.amount
    for i in range(0, res.amount):
        var node = knife.instantiate()
        node.global_rotation = angle_step * i
        node.set_damage(res.damage * player.get_attack_multiplier())
        add_child(node)

func _process(_delta):
    if not _is_spawned or _waiting_timer: return

    global_rotation += res.speed * _delta

    if get_child_count() == 0:
        _waiting_timer = true
        timer.start(res.respawn_time)

func _on_timer_timeout():
    _is_spawned = false
    _waiting_timer = false