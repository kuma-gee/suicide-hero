extends Node

const GENERAL_SECTION = "general"
const AUDIO_SECTION = "audio"
const INPUT_SECTION = "input"

const CONFIG_FILE = "user://settings.cfg"

onready var default_theme = load(ProjectSettings.get_setting("gui/theme/custom"))

var _config = ConfigFile.new()


func _ready():
	load_settings()

func load_settings():
	var error = _config.load(CONFIG_FILE)
	if error != OK:
		print("Error loading settings: %s" % error)
		return
		
	_load_general_settings()
	_load_audio_settings()
	_load_input_settings()

func _load_general_settings():
	var size = _config.get_value(GENERAL_SECTION, "font_size", null)
	if size != null:
		set_font_size(size)
		
	var lang = _config.get_value(GENERAL_SECTION, "language", null)
	if lang != null:
		set_language(lang)

func _load_audio_settings():
	for i in range(0, AudioServer.bus_count):
		var name = AudioServer.get_bus_name(i)
		var value = _config.get_value(AUDIO_SECTION, name)
		if value != null:
			AudioServer.set_bus_volume_db(i, value)

func _load_input_settings():
	for section in _config.get_sections():
		if not section.begins_with(INPUT_SECTION + "."): continue
		
		var mappings = {}
		for action in _config.get_section_keys(section):
			var type = _config.get_value(section, action)
			if type != null:
				mappings[action] = type
		
		for p in InputManager.get_profiles():
			var profile := p as InputProfile
			if section.ends_with(profile.get_profile_name()):
				profile.load_mappings(mappings)
				break


func save_general_settings():
	_config.set_value(GENERAL_SECTION, "font_size", get_font_size())
	_config.set_value(GENERAL_SECTION, "language", get_language())
	save_config()

func save_audio_settings():
	for i in range(0, AudioServer.bus_count):
		var name = AudioServer.get_bus_name(i)
		var value = AudioServer.get_bus_volume_db(i)
		_config.set_value(AUDIO_SECTION, name, value)
	save_config()
	
func save_input_settings():
	for p in InputManager.get_profiles():
		var profile := p as InputProfile
		for action in profile.mappings:
			var type = profile.mappings[action]
			var section = "%s.%s" % [INPUT_SECTION, profile.get_profile_name()]
			_config.set_value(section, action, type)
	save_config()

func save_config():
	if Env.is_web(): return
	_config.save(CONFIG_FILE)


func set_language(lang: String) -> void:
	TranslationServer.set_locale(lang.to_lower())

func get_language() -> String:
	var locale = TranslationServer.get_locale()
	var split = locale.split("_")
	return split[0]

func set_font_size(size: int) -> void:
	var font = default_theme.get("default_font")
	font.set("size", size)
	Events.emit_signal("font_size_changed")

func get_font_size() -> int:
	var font = default_theme.get("default_font")
	return font.get("size")

