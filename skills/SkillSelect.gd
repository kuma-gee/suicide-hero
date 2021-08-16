extends Node2D

signal skill_selected(skill)

export var offset = 25

const skill_select_item = preload("res://skills/SkillSelectItem.tscn")
const skill_map = {
	Skill.Type.HEALTH: preload("res://skills/hp-up.png"),
	Skill.Type.SPEED: preload("res://skills/speed-up.png"),
	Skill.Type.STRENGTH: preload("res://skills/strength-up.png"),
}

enum {
	SkillLeft,
	SkillRight,
}

const slot_action = {
	SkillLeft: "skill_1",
	SkillRight: "skill_2",
}

var _current_skill_1: int
var _current_skill_2: int

func _unhandled_input(event):
	if event.is_action_pressed("skill_1"):
		_select_skill(_current_skill_1)
		get_tree().set_input_as_handled()
	elif event.is_action_pressed("skill_2"):
		_select_skill(_current_skill_2)
		get_tree().set_input_as_handled()


func _select_skill(skill) -> void:
	emit_signal("skill_selected", skill)
	for child in get_children():
		remove_child(child)


func select_skills(skill1: int, skill2: int) -> void:
	_current_skill_1 = skill1
	_current_skill_2 = skill2
	
	var sprite1 = _create_skill_select(skill1, SkillLeft)
	var sprite2 = _create_skill_select(skill2, SkillRight)
	
	add_child(sprite1)
	sprite1.global_position.x -= offset
	
	add_child(sprite2)
	sprite2.global_position.x += offset

func _create_skill_select(skill: int, slot: int) -> Sprite:
	if not skill_map.has(skill): return null
	
	var select = skill_select_item.instance()
	select.texture = skill_map.get(skill)
	select.key = _get_skill_key(slot)
	return select


func _get_skill_key(skill_slot: int) -> InputEvent:
	if not slot_action.has(skill_slot): return null
	var actions = InputMap.get_action_list(slot_action.get(skill_slot))
	return actions[0] if actions.size() > 0 else null
