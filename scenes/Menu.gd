class_name Menu extends Control


enum {
	MainMenu,
	Lobby,
	Options,
	Pause,
	GameOver,
	InGame,
	Loading,
}

const screen_scene_map = {
	MainMenu: preload("res://scenes/gui/menu/MainMenu.tscn"),
	Options: preload("res://scenes/gui/menu/Options.tscn"),
	Pause: preload("res://scenes/gui/pause/Pause.tscn"),
	GameOver: preload("res://scenes/gui/gameover/GameOver.tscn"),
	Loading: preload("res://scenes/gui/loading/Loading.tscn"),
}
