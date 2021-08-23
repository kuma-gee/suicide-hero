class_name HealthUp extends Skill

export var increase = 10

func apply(player: Player) -> void:
	player.stats.health.max_value += increase
