extends Node
class_name StateMinerTravelToMine

export(NodePath) var ai_path

onready var ai = get_node(ai_path)
var fsm: StateMachine
var target = null
var target_threshold: float = 0.5


func enter():
	if not target:
		target = Game.mines[0]
		ai.build_path(owner.nav, target)
	elif target and target_threshold:
		pass
	pass


func physics_process(_delta):
	ai.move_to_target(_delta)
	pass


func exit(next_state):
	pass
