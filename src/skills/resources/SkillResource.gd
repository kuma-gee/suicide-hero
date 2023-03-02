class_name SkillResource
extends Resource

enum Type {
    STAT_UP,
}

enum Group {
    WEAPON,
    ITEM,
    PASSIVE,
}

@export var text: String;
@export var name: String;
@export var icon: Texture;

@export var type := Type.STAT_UP
@export var group := Group.PASSIVE

@export var level := 0 # ??

@export var resource: Resource