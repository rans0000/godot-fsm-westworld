extends State

const DEBUG = Game.DEBUG || false
var fsm: StateMachine
var target = null



func enter():
	owner.set_target_reached(false)
	if DEBUG: print("enter: walk to mine")
	target = Game.mines[0]
	owner.ai.build_path(owner.nav, target)
	owner.playback.travel("anim_walk-loop")
	pass


func physics_process(delta):
	if not owner.is_target_reached():
		var velocity = owner.ai.move_to_target(delta)
		owner.ai.rotate_to_direction(delta, velocity)
	pass


func exit():
	target = null
	owner.set_target_reached(true)
	if DEBUG: print("exit-state walk mine")
	pass


func on_message(_message_data):
	match _message_data.name:
		"target_reached":
			fsm.change_state_to(owner.states.STATE_DIG_AT_MINE)
	pass
