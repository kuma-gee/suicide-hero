extends MarginContainer

@export var health: Label
@export var speed: Label
@export var pickup: Label
@export var attack: Label
@export var attack_speed: Label
@export var damage: Label

func _ready():
	var player = get_tree().get_nodes_in_group("Player")[0]
	var mult: Multiplier = player.get_multiplier()
	
	health.text = "+ %s%%" % _to_percentage(mult.get_health())
	speed.text = "+ %s%%" % _to_percentage(mult.get_move_speed())
	pickup.text = "+ %s%%" % _to_percentage(mult.get_pickup())
	attack.text = "+ %s%%" % _to_percentage(mult.get_attack())
	attack_speed.text = "+ %s%%" % _to_percentage(mult.get_attack_sepeed())
	damage.text = "+ %s%%" % _to_percentage(mult.get_damage())
	
func _to_percentage(value: float):
	return roundf(value * 100)
