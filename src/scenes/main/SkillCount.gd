extends Control

var skill: int

@onready var texture_label := $TextureLabel

#func _ready():
#	var skill_tex: Texture = Skill.skill_map[skill]
#	print("Skill %s: %s" % [skill, skill_tex])
#	texture_label.set_texture(skill_tex)
#	texture_label.set_label(str(1))

func set_count(count: int) -> void:
	texture_label.set_label(str(count))
