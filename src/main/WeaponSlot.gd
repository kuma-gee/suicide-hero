class_name SkillSlot
extends Control

@onready var icon: TextureRect = $Icon
@onready var border: TextureRect = $Border

func _ready():
	modulate = Color(1, 1, 1, 0.5)

func set_icon(tex: Texture2D):
	icon.texture = tex
	modulate = Color.WHITE
