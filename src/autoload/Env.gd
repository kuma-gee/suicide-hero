extends Node

var version = "dev" setget _set_version

func _set_version(v: String) -> void:
	if v == "": return
	version = v

func is_prod() -> bool:
	return version != "dev"
