extends MarginContainer

@export var health: Label
@export var speed: Label
@export var pickup: Label
@export var attack: Label
@export var attack_speed: Label
@export var damage: Label

func _ready():
	var player = get_tree().get_nodes_in_group("Player")[0]
	
	health.text = "+ %s%%" % _to_percentage(player.get_health_multiplier())
	speed.text = "+ %s%%" % _to_percentage(player.get_move_speed_multiplier())
	pickup.text = "+ %s%%" % _to_percentage(player.get_pickup_multiplier())
	attack.text = "+ %s%%" % _to_percentage(player.get_attack_multiplier())
	attack_speed.text = "+ %s%%" % _to_percentage(player.get_attack_speed_multiplier())
	damage.text = "+ %s%%" % _to_percentage(player.get_damage_multiplier())
	
func _to_percentage(value: float):
	return roundf((value - 1.0) * 100)
