class_name ThrowBody
extends CharacterBody2D

signal stopped

@export var speed := 300
@export var deaccel := 600
@export var min_random_speed := 0.5

var dir := Vector2.ZERO

func _ready():
	velocity = dir * speed * randf_range(min_random_speed, 1)

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, deaccel * delta)
	move_and_slide()
	
	if velocity.length() == 0:
		stopped.emit()
