class_name RandomThrow
extends Node

var _can_fire = true

func _ready():
    var timer = Timer.new()
    timer.oneshot = true
    timer.autostart = false
    timer.timeout.connect(_on_timer_timeout)
    add_child(timer)


func random_throw(res: ThrowResource) -> Array[Vector2]:
	if not _can_fire or res == null: return []
    _can_fire = false

    var result = []
    for i in range(0, resource.amount):
        var rand_angle = TAU * randf()
        var dir = Vector2.UP.rotated(rand_angle)
        var node = throwable.instantiate()
        dir *= Random.random_int(resource.min_force, resource.max_force)
        result.append(dir)

    timer.start(resource.firerate)
    return result

func _on_timer_timeout():
    _can_fire = true
