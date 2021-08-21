extends CanvasLayer

signal screen_changed(screen)

enum {
	Main,
	Intro,
	InGame,
	GameOver,
	Pause,
}

const screen_scene_map = {
	Main: preload("res://scenes/menu/MainMenu.tscn"),
	Intro: preload("res://scenes/menu/Intro.tscn"),
	GameOver: preload("res://scenes/menu/GameOver.tscn"),
	Pause: preload("res://scenes/menu/Pause.tscn"),
}

onready var stack := $MenuStack
onready var theme := $Theme


func _ready():
	stack.connect("removed", self, "_add_current_menu")
	stack.connect("added", self, "_add_current_menu")


func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		stack.pop()


func open_menu(menu, clear = false):
	open({"menu": menu})


func open(data = {}, clear = false):
	if clear:
		stack.clear()
	stack.push(data)


func back_menu():
	if stack.size() <= 1:
		return
	
	stack.pop()


func _add_current_menu(value):
	_remove_all_menus()
	
	var menu = stack.current["menu"]
	if screen_scene_map.has(menu):
		var scene = screen_scene_map[menu]
		var instance = scene.instance()
		theme.add_child(instance)
		if instance.has_method("init"):
			instance.init(stack.current)
	
	emit_signal("screen_changed", menu)
	_update_gui()

func _remove_all_menus():
	for child in theme.get_children():
		theme.remove_child(child)

func _update_gui():
	var filter = Control.MOUSE_FILTER_IGNORE if theme.get_child_count() == 0 else Control.MOUSE_FILTER_STOP
	theme.mouse_filter = filter
