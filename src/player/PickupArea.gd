class_name PickupArea extends Area2D

#@export var player_path: NodePath
@export var player: Player# = get_node(player_path) if player_path else owner
