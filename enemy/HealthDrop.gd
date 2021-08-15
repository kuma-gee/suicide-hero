extends Area2D

export var heal = 20

func _on_HealthDrop_area_entered(area):
	if not area is PickupArea: return
	
	area.player.heal(heal)
	queue_free()
