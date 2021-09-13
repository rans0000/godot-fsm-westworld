extends State

const DEBUG = Game.DEBUG || false
var fsm: StateMachine
var target = null



func enter():
	owner.set_target_reached(false)
	if DEBUG: print("enter: walk to home")
	target = owner.home
	owner.ai.build_path(owner.nav, target)
	owner.playback.travel("anim_walk-loop")
	pass


func physics_process(delta):
	if not owner.is_target_reached():
		var velocity = owner.ai.move_to_target(delta, "miner_reached_home")
		owner.ai.rotate_to_direction(delta, velocity)
	pass


func exit():
	target = null
	owner.set_gold(0)
	owner.set_target_reached(true)
	if DEBUG: print("exit-state walk-home")
	pass


func on_message(_message_data):
	match _message_data.name:
		"miner_reached_home":
			fsm.change_state_to(owner.states.STATE_GOTO_MINE_AND_DIG)
	pass
