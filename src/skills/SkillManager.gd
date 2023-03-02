extends Node

signal skill_updated(skill_res, level)

@export var player: Player

@export var max_weapons := 3
@export var max_items := 3

var skills = {}

var _logger = Logger.new("SkillManager")

# TODO: group by this type
var _weapons = []
var _items = []

var _current_skill_pool := []
var _skill_type_node_map = {}

func _ready():
    for child in get_children():
        if child is Skill:
            _skill_type_node_map[child.type] = child
            _add_skill_to_pool(child)

func _add_skill_to_pool(skill: Skill):
    var new_skill = skill.get_skill_for_level()
    if new_skill:
        _current_skill_pool.append(new_skill)
        _current_skill_pool.shuffle()


func add_skill(res: SkillResource) -> void:
	if not _skill_type_node_map.has(res.type):
        return
	
	var skill = _skill_type_node_map[res.type]
    _current_skill_pool.erase(res)

	if skill:
		skill.apply(player, res)
        _add_skill_to_pool(skill)
        
		emit_signal("skill_updated", res, skill.level)
    else:
        _logger.info("No skill found for %s" % res)


func get_random_skills(count: int) -> Array:
    var result = []
    for i in range(0, count):
        var skill = _current_skill_pool[randi() % _current_skill_pool.size()]
        result.append(skill)

    return skill;
	