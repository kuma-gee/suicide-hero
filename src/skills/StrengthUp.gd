class_name StrengthUp extends Skill

export var increase = 5

func apply(player: Player) -> void:
	player.increase_damage(increase)
