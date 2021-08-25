extends KinematicBody

export(NodePath) var navigation_node
export(NodePath) var mine_node
#
#
onready var nav = get_node(navigation_node)
onready var target = get_node(mine_node)



func _ready():
	pass


func _physics_process(_delta):
	pass

