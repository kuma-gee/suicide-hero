extends MarginContainer

@export var health: Label
@export var speed: Label
@export var pickup: Label
@export var attack: Label
@export var attack_speed: Label
@export var damage: Label
@export var crit_chance: Label

func _ready():
	var player = get_tree().get_nodes_in_group("Player")[0]
	
	health.text = "+ %s%%" % _from_multiplier(player.get_health_multiplier())
	speed.text = "+ %s%%" % _from_multiplier(player.get_move_speed_multiplier())
	attack.text = "+ %s%%" % _from_multiplier(player.get_attack_multiplier())
	attack_speed.text = "+ %s%%" % _from_multiplier(player.get_attack_speed_multiplier())
	damage.text = "+ %s%%" % _from_multiplier(player.get_damage_multiplier())
	
	pickup.text = "+ %s%%" % _from_percentage(player.get_pickup_increase())
	crit_chance.text = "+ %s%%" % _from_percentage(player.get_crit_chance())

func _from_multiplier(value: float):
	return _from_percentage(value - 1.0)


func _from_percentage(value: float):
	return roundf((value) * 100)
