class_name StatUpgradeResource
extends UpgradeResource

@export var health: float
@export var speed: float
@export var pickup: float
@export var attack: float
@export var attack_speed: float

# @export var crit: float

# @export var armor: int
# @export var dodge: float


func get_skill():
	return SkillManager.Skill.STATS