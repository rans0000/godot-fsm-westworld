extends Spatial

onready var Game = get_node("/root/Game")

func _ready():
	Game.restaurants.push_back(self)
	pass
