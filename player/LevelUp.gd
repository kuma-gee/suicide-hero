extends Node2D

onready var texture_rect := $TextureRect

func set_texture(tex: Texture) -> void:
	texture_rect.texture = tex
