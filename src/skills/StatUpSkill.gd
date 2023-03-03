class_name StatUpSkill
extends Skill

@export var skills: Array[StatIncreaseResource]

var _logger = Logger.new("StatUpSkill")

func get_skills():
	return skills

func apply(player: Player, resource: Resource):
	if resource == null:
		_logger.debug("Called without resource to apply")
		return

	var res = resource as StatIncreaseResource
	if resource.health != 0:
		player.stats.health.max_value *= res.health

	if resource.speed != 0:
		player.increase_speed(res.speed)

	if resource.pickup != 0:
		player.increase_magnet(res.pickup)

	if resource.attack != 0:
		player.increase_damage(res.attack)
