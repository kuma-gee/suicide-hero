class_name Skill extends Node

@export var type := Type.STAT_UP
@export var skills: Array[SkillResource]

var level = 0

func apply(_player: Player, _res: Resource) -> void:
	pass

# TODO: get one or mulitple ??
func get_skills_for_level() -> Array[SkillResource]:
    var result = []
    for skill in skills:
        if level == skill.level:
            result.append(skill)
    return result

# Skill 1
#   SkillResource LV1
#   SkillResource LV2
#   SkillResource LV3
#   SkillResource LV4
# Skill 2
#   SkillResource LV1
#   SkillResource LV2
# Skill 3
#   SkillResource LV0
#   SkillResource LV0