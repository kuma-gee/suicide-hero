class_name FireRateUp extends Skill

export var increase := 0.05

func apply(player: Player) -> void:
	player.increase_firerate(increase)
