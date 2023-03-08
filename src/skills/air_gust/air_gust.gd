class_name AirGust
extends Area2D

func _ready():
    area_entered.connect(_on_area_enter)

func _on_area_enter(area: Area2D):
    if area is Debuffer:
        pass

func get_upgrade():
	return null

func apply(res: UpgradeResource) -> void:
	pass

func activate(player: PlayerResource) -> void:
	pass