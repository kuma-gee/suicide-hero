extends ThrowBody

@export var timer: Timer
@export var spike_sprite: PackedScene

var damage := 0
var amount := 0
var radius := 0
var lifetime := 0.0

var _thrown := false
var _spikes := {}

func _ready():
	($CollisionShape2D.shape as CircleShape2D).radius = radius
	timer.start(lifetime)
	
	_spikes = _create_spikes_with_destination()

func _process(_delta):
	for spike_dest in _spikes:
		var spike = _spikes[spike_dest]
		var vel = velocity.length() / force
		var pos = spike_dest * (1-vel)
		spike.position = pos


func _create_spikes_with_destination() -> Dictionary:
	var result = {}
	for i in range(0, amount):
		var max_dir = Vector2.UP.rotated(TAU * randf()) * radius
		var dest = max_dir * randf()
		var node = spike_sprite.instantiate() as DamagingItem
		node.set_damage(damage)
		add_child(node)
		result[dest] = node
	
	return result


func _on_timer_timeout():
	queue_free()
