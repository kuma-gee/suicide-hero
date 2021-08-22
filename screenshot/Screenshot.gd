extends Node

export var output_path = "res://screenshot/output"

#onready var main = ProjectSettings.get_setting("application/run/main_scene")
var main = "res://scenes/main/Main.tscn"
var main_scene: Node

const COVER_SIZE = Vector2(630, 500)

func take_screenshot(name: String, size := Vector2.ZERO):
	var img = get_viewport().get_texture().get_data()
	img.flip_y()
	if size != Vector2.ZERO:
		img.crop(size.x, size.y)
	img.save_png(output_path + "/" + name)


#func _ready():
#	var dir = Directory.new()
#	if not dir.file_exists(output_path):
#		dir.make_dir_recursive(output_path)
#
#	main_scene = load(main).instance()
#	get_tree().current_scene.add_child(main_scene)


func finish():
	get_tree().quit()

#func _get_player():
#	return main_scene.get_node("Player")
#
#func _get_skill_manager():
#	return main_scene.get_node("SkillManager")

func _on_StartTimer_timeout():
	pass
#	press_key("fire")
#	yield(get_tree().create_timer(0.05), "timeout")
#	take_screenshot("start.png", COVER_SIZE)
	
#	take_screenshot("enemies.png")
	
#	var player = _get_player()
#	yield(player, "level_up")
#	press_key("move_left", 1)
	
#	yield(get_tree().create_timer(1), "timeout")
#	take_screenshot("action.png")
#
#	press_key("skill_1")
#	yield(get_tree().create_timer(0.5), "timeout")
#	take_screenshot("skill.png")
	
#	finish()


# TODO: share with unit tests?
func _press_key(input: String, strength = 0) -> InputEvent:
	return _create_input(input, strength, true)

func _release_key(input: String) -> InputEvent:
	return _create_input(input, 0, false)

func _create_input(input: String, strength = 0, pressed = true) -> InputEvent:
	InputEventKey
	
	var ev = InputEventAction.new()
	ev.action = input
	ev.pressed = pressed
	ev.strength = strength
	ev.device = 0
	return ev

func press_key(input: String, strength = 0) -> InputEvent:
	return enter_input(_press_key(input, strength))


func release_key(input: String) -> InputEvent:
	return enter_input(_release_key(input))


func enter_input(ev: InputEvent) -> InputEvent:
	get_tree().input_event(ev)
	return ev
