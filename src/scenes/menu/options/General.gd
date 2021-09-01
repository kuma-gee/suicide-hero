extends MenuBase

export var font_size_increment := 1

onready var languages := $CenterContainer/VBoxContainer/MainContainer/VBoxContainer/Languages
onready var font_label := $CenterContainer/VBoxContainer/MainContainer/VBoxContainer/HBoxContainer/Font
onready var default_theme = load(ProjectSettings.get_setting("gui/theme/custom"))

func _ready():
	var locale = TranslationServer.get_locale()
	languages.set_value("LANG_" + locale.to_upper())
	_update_font_label()

func _on_Languages_item_selected(index):
	var lang = languages.get_item_text(index)
	var locale = lang.substr("LANG_".length())
	TranslationServer.set_locale(locale.to_lower())


func _on_DecreaseFont_pressed():
	var font = default_theme.get("default_font")
	font.set("size", font.get("size") - font_size_increment)
	Events.emit_signal("font_size_changed")
	_update_font_label()


func _on_IncreaseFont_pressed():
	var font = default_theme.get("default_font")
	font.set("size", font.get("size") + font_size_increment)
	Events.emit_signal("font_size_changed")
	_update_font_label()

func _update_font_label():
	font_label.text = str(get_font("font").get("size"))
