extends MenuBase

onready var version := $CenterContainer/VBoxContainer/MainContainer/Version

func _ready():
	version.text = tr("VERSION") + " " + Env.version
