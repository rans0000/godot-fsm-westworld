extends Node
class_name StateMinerTravelToMine

export(NodePath) var ai_path

onready var ai = get_node(ai_path)
var fsm: StateMachine
var target = null



func enter():
	if not target:
		target = Game.mines[0]
		ai.build_path(owner.nav, target)
		owner.playback.travel("anim_walk-loop")
	pass


func physics_process(delta):
	if not owner.is_target_reached():
		var velocity = ai.move_to_target(delta)
		ai.rotate_to_direction(delta, velocity)
	pass


func exit(_next_state):
	target = null
	owner.set_target_reached(true)
	print("exit-state", _next_state)
	pass
