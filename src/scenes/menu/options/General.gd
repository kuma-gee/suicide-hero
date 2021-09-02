extends MenuBase

export var font_size_increment := 1

onready var languages := $CenterContainer/VBoxContainer/MainContainer/VBoxContainer/Languages
onready var font_label := $CenterContainer/VBoxContainer/MainContainer/VBoxContainer/HBoxContainer/Font
onready var default_theme = load(ProjectSettings.get_setting("gui/theme/custom"))


func _ready():
	languages.set_value("LANG_" + Settings.get_language().to_upper())
	_update_font_label()


func _on_Languages_item_selected(index):
	var lang = languages.get_item_text(index)
	var locale = lang.substr("LANG_".length())
	Settings.set_language(locale)


func _on_DecreaseFont_pressed():
	_change_font_size(-font_size_increment)


func _on_IncreaseFont_pressed():
	_change_font_size(font_size_increment)


func _change_font_size(delta: int) -> void:
	var font = default_theme.get("default_font")
	var size = font.get("size") + delta
	Settings.set_font_size(size)
	_update_font_label()


func _update_font_label():
	font_label.text = str(Settings.get_font_size())


func _exit_tree():
	Settings.save_general_settings()
