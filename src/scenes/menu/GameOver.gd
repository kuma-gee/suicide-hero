extends PausedMenu

@onready var score := $CenterContainer/VBoxContainer/Score
@onready var sound := $GameOverSound

func _ready():
	sound.play()
	super._ready()


func init(data) -> void:
	score.text = tr("FINAL_LEVEL") + ": " + str(data["score"])
