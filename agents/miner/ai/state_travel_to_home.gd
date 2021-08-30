extends Node

export(NodePath) var ai_path

onready var ai = get_node(ai_path)
var fsm: StateMachine
var target = null



func enter():
	owner.set_target_reached(false)
	print("enter: walk to home")
	if not target:
		target = owner.home
		ai.build_path(owner.nav, target)
		owner.playback.travel("anim_walk-loop")
	pass


func physics_process(delta):
	if not owner.is_target_reached():
		var velocity = ai.move_to_target(delta)
		ai.rotate_to_direction(delta, velocity)
	pass


func exit():
	target = null
	owner.set_target_reached(true)
	print("exit-state walk-home")
	fsm.change_state_to(owner.states.STATE_MINER_TRAVEL_TO_MINE)
	pass
