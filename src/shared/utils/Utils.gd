class_name Utils

static func get_script_path(script: Object) -> String:
	return script.get_script().get_path().get_base_dir() + "/"
