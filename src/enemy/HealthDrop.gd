class_name HealthDrop extends Area2D

enum Size {
	SMALL,
	MEDIUM,
	LARGE,
}

var heal_size := Size.SMALL

func pickup(player: Player):
	player.heal(_get_heal_amount())
	queue_free()

func _get_heal_amount() -> int:
	match heal_size:
		Size.SMALL: return 10
		Size.MEDIUM: return 25
		Size.LARGE: return 50
		_: return 0
