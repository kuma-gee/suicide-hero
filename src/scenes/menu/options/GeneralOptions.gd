extends GUIMenu

onready var languages := $CenterContainer/VBoxContainer2/VBoxContainer/Languages

func _ready():
	var locale = TranslationServer.get_locale()
	languages.set_value("LANG_" + locale.to_upper())


func _on_Languages_item_selected(index):
	var lang = languages.get_item_text(index)
	var locale = lang.substr("LANG_".length())
	TranslationServer.set_locale(locale.to_lower())
