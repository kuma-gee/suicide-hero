class_name PlayerResource
extends Resource

@export var health: int
@export var speed := 0.0
@export var attack := 0.0
@export var pickup := 0.0

#@export var crit: float;

# @export var armor: int;
# @export var dodge: float;

func get_attack_multiplier():
    return 1 + attack