extends Node2D

signal skill_selected(skill)

@export var offset = 25

const skill_select_item = preload("res://src/skills/SkillSelectItem.tscn")

enum {
	SkillLeft,
	SkillRight,
}

const slot_action = {
	SkillLeft: "skill_1",
	SkillRight: "skill_2",
}

@onready var skill_queue := $Queue
@onready var selected_sound := $SelectedSound

var _current_skills := []

func _unhandled_input(event):
	if _current_skills.size() == 2:
		if event.is_action_pressed("skill_1"):
			_select_skill(_current_skills[0])
			get_viewport().set_input_as_handled()
		elif event.is_action_pressed("skill_2"):
			_select_skill(_current_skills[1])
			get_viewport().set_input_as_handled()


func _select_skill(skill) -> void:
	emit_signal("skill_selected", skill)
	for child in get_children():
		if child is SkillSelectItem:
			remove_child(child)
	_current_skills = []
	skill_queue.auto_deque = true
	selected_sound.play()


func select_skills(skill1: int, skill2: int) -> void:
	skill_queue.queue([skill1, skill2])

func _show_skill_select(skills: Array):
	if skills.size() != 2: return
	_current_skills = skills
	
	var sprite1 = _create_skill_select(skills[0], SkillLeft)
	var sprite2 = _create_skill_select(skills[1], SkillRight)
	
	add_child(sprite1)
	sprite1.global_position.x -= offset
	sprite1.start_autoselect()
	sprite1.connect("auto_selected", func(): _select_skill(_current_skills[0]))
	
	add_child(sprite2)
	sprite2.global_position.x += offset
	skill_queue.auto_deque = false

func _create_skill_select(skill: int, slot: int):
	if not Skill.skill_map.has(skill): return null
	
	var select = skill_select_item.instantiate()
	select.texture = Skill.skill_map.get(skill)
	select.key = _get_skill_key(slot)
	return select


func _get_skill_key(skill_slot: int) -> InputEvent:
	if not slot_action.has(skill_slot): return null
	return InputManager.get_profile().get_input(slot_action.get(skill_slot))


func _on_Queue_dequed(value):
	_show_skill_select(value)
