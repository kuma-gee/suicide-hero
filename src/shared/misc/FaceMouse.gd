class_name FaceMouse extends Node2D

export var bullet: PackedScene

onready var gun_point := $GunPoint
onready var fire_rate_timer := $FireRate
onready var shot_sound := $ShotSound

var damage_increase = 0
var homing = false

var shoot = false
var _can_shoot = true

func _process(_delta):
	if shoot and _can_shoot:
		_shoot()


func _shoot() -> void:
	_can_shoot = false
	var bullet_node: HitBox2D = bullet.instance()
	bullet_node.damage += damage_increase
	bullet_node.get_node("HomingArea").monitoring = homing
	
	get_tree().current_scene.add_child(bullet_node)
	bullet_node.global_transform = gun_point.global_transform
	bullet_node.global_rotation = gun_point.global_rotation
	
	shot_sound.play()
	fire_rate_timer.start()


func _on_FireRate_timeout():
	_can_shoot = true
