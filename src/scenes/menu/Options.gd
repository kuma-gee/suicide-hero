extends MarginContainer

onready var languages := $TabContainer/SETTINGS/CenterContainer/VBoxContainer2/VBoxContainer/Languages
onready var tabs := $TabContainer

func _ready():
	_init_languages_select()
	

func _unhandled_input(event):
	if event.is_action_pressed("ui_right"):
		if tabs.current_tab >= (tabs.get_tab_count() - 1):
			tabs.current_tab = 0
		else:
			tabs.current_tab += 1
	elif event.is_action_pressed("ui_left"):
		if tabs.current_tab == 0:
			tabs.current_tab = tabs.get_tab_count() - 1
		else:
			tabs.current_tab -= 1


func _init_languages_select():
	var locale = TranslationServer.get_locale()
	languages.set_value("LANG_" + locale.to_upper())


func _on_Languages_item_selected(index):
	var lang = languages.get_item_text(index)
	var locale = lang.substr("LANG_".length())
	TranslationServer.set_locale(locale.to_lower())


func _on_TabContainer_tab_changed(tab_idx: int):
	var tab = tabs.get_child(tab_idx)
	tab.tab_changed()
