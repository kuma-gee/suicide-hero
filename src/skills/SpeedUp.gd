class_name SpeedUp extends Skill

@export var increase = 50

func apply(player: Player) -> void:
	player.increase_speed(increase)
