class_name StatUpSkill
extends Skill

@export var skills: Array[StatIncreaseResource]

var _logger = Logger.new("StatUpSkill")

func apply(player: Player, resource: StatIncreaseResource):
    if resource == null:
        _logger.debug("Called without resource to apply")
        return

    if resource.health != 0:
        player.stats.health.max_value += increase

    if resource.speed != 0:
        player.increase_speed(increase)

    if resource.pickup != 0:
        player.increase_magnet(increase)

    if resource.attack != 0:
        player.increase_damage(increase)
