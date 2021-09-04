extends CenterContainer

onready var _tex := $TextureRect
onready var _label_sprite := $LabelSprite

func set_texture(tex):
	_tex.texture = tex

func set_label(t: String):
	_label_sprite.set_label(t)
