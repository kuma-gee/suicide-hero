extends Area2D

export var heal = 20

func _on_HealthDrop_body_entered(body):
	if body.has_method("heal"):
		body.heal(heal)
	queue_free()
