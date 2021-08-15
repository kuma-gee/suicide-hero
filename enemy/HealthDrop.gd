extends Area2D

export var heal = 10

func _on_HealthDrop_area_entered(area):
	if not area is PickupArea: return
	
	area.player.heal(heal)
	queue_free()
