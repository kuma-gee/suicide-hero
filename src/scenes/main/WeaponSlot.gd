class_name WeaponSlot
extends CenterContainer

@export var default_icon: Texture2D

@onready var icon: TextureRect = $Icon
@onready var border: TextureRect = $Border

func _ready():
	set_icon(null)

func set_icon(tex):
	icon.texture = tex if tex != null else default_icon
	modulate = Color.WHITE if tex != null else Color(1, 1, 1, 0.5)
	
