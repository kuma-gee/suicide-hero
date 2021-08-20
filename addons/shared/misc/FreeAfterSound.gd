extends AudioStreamPlayer

export var node_path: NodePath
onready var node: Node2D = get_node(node_path) if node_path else owner

func _ready():
	connect("finished", self, "_free")

func _free():
	queue_free()

func start():
	node.hide()
	play()
