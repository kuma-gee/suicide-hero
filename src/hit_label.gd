extends Label

@export var normal_font: LabelSettings
@export var crit_font: LabelSettings

@export var fade_effect: NewEffect

@export var force := 100
@export var angle_diff := 30.0
@export var gravity := 5

var is_crit := false
var vel := Vector2.ZERO

func _ready():
	label_settings = crit_font if is_crit else normal_font
	fade_effect.setup_props("modulate", Color.WHITE, Color.TRANSPARENT)
	fade_effect.start()
	
	var rand_angle = randf_range(-angle_diff, angle_diff)
	vel = Vector2.UP.rotated(deg_to_rad(rand_angle)) * force

func _process(delta):
	vel += Vector2.DOWN * gravity
	position += vel * delta

func set_label(dmg: int):
	text = str(dmg)

func set_miss():
	text = tr("MISS")

func _on_life_time_timeout():
	queue_free()
