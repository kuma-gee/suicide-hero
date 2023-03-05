extends MarginContainer

@export var health: Label
@export var speed: Label
@export var pickup: Label
@export var attack: Label

func _ready():
	var player = get_tree().get_nodes_in_group("Player")[0]
	var res: PlayerResource = player.get_stats()
	
	health.text = "%s / %s" % [player.get_current_health(), res.health]
	speed.text = "+ %s%%" % _to_percentage(res.speed)
	pickup.text = "+ %s%%" % _to_percentage(res.pickup)
	attack.text = "+ %s%%" % _to_percentage(res.attack)
	
func _to_percentage(value: float):
	var v = ceil(value * 100)
	return floor(v - 100)
