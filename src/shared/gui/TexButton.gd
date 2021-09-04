extends TextureButton

func _ready():
	on_focus_exit()

func _on_TexButton_focus_entered():
	on_focus()


func _on_TexButton_focus_exited():
	on_focus_exit()


func _on_TexButton_mouse_entered():
	on_focus()


func _on_TexButton_mouse_exited():
	on_focus_exit()


func on_focus():
	modulate.a = 1


func on_focus_exit():
	modulate.a = 0.5

func set_disabled(disabled: bool) -> void:
	var value = 0.5 if disabled else 1.0
	self_modulate.r = value
	self_modulate.g = value
	self_modulate.b = value
	self.disabled = disabled
