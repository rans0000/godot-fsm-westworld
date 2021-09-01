extends Spatial

onready var Game = get_node("/root/Game")

func _ready():
	Game.mines.push_back(self)
	pass


func get_interact_position(_interaction_point):
	var pos =  global_transform.origin
	return pos
