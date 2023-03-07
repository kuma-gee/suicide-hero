extends CharacterBody2D

@export var spike_sprite: PackedScene
@export var deaccel := 600
@export var min_force := 200
@export var max_force := 500

var dir := Vector2.ZERO
var damage := 0
var amount := 0
var radius := 0
var max_hits := 0

var _thrown := false

func _on_timer_timeout():
    queue_free()
    
func _ready():
    # hitbox.damage = resource.damage

func _physics_process(delta):
    velocity = dir.move_towards(Vector2.ZERO, deaccel * delta)
    move_and_slide()

    if velocity.length() == 0 and not _thrown:
        _thrown = true
        for i in range(0, resource.amount):
            var node = spike_sprite.instantiate()
            node.set_damage(damage)
            add_child(node)


