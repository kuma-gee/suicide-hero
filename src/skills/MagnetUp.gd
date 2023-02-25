extends Skill

@export var increase := 10

func apply(player: Player):
	player.increase_magnet(increase)
