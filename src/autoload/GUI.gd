extends CanvasLayer

signal screen_changed(screen)

enum {
	Main,
	Options,
	GeneralOptions,
	AudioOptions,
	ControlOptions,
	Intro,
	InGame,
	GameOver,
	Pause,
	SkillSelect,
}

const screen_scene_map = {
	Main: preload("res://src/scenes/menu/MainMenu.tscn"),
	Options: preload("res://src/scenes/menu/options/Options.tscn"),
	GeneralOptions: preload("res://src/scenes/menu/options/General.tscn"),
	AudioOptions: preload("res://src/scenes/menu/options/Audio.tscn"),
	ControlOptions: preload("res://src/scenes/menu/options/Controls.tscn"),
	Intro: preload("res://src/scenes/menu/Intro.tscn"),
	GameOver: preload("res://src/scenes/menu/GameOver.tscn"),
	Pause: preload("res://src/scenes/menu/Pause.tscn"),
	SkillSelect: preload("res://src/scenes/menu/skill_select.tscn")
}

@onready var stack := $MenuStack
@onready var theme := $Theme

var current #: GUIMenu

func _ready():
	var _x = stack.connect("removed", func(x): _add_current_menu(x, false))
	var _y = stack.connect("added", func(x): _add_current_menu(x, true))


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		stack.pop()


func open_menu(menu, clear = false):
	open({"menu": menu}, clear)


func open(data = {}, clear = false):
	if clear:
		stack.clear()
	stack.push(data)


func back_menu():
	if stack.size() <= 1:
		return
	
	stack.pop()

func clear():
	open_menu(InGame, true)

func _add_current_menu(_value, added: bool):
	var menu = stack.current["menu"]

	if current != null and current.has_method("get_data"):
		var data = current.get_data()
		var current_data = stack.current
		for key in data:
			current_data[key] = data[key]
		stack.replace(current_data)
	
	_remove_all_menus()
	
	if screen_scene_map.has(menu):
		var scene = screen_scene_map[menu]
		current = scene.instantiate()
		theme.add_child(current)
		if current.has_method("init") and added:
			current.init(stack.current)
	
	emit_signal("screen_changed", menu)
	_update_gui()

func _remove_all_menus():
	for child in theme.get_children():
		theme.remove_child(child)

func _update_gui():
	var filter = Control.MOUSE_FILTER_IGNORE if theme.get_child_count() == 0 else Control.MOUSE_FILTER_STOP
	theme.mouse_filter = filter
