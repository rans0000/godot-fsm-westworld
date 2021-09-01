extends State

var fsm: StateMachine
const DEBUG = Game.DEBUG || false


func enter():
	if DEBUG: print("enter: digging")
	owner.playback.travel("anim_digging")
	pass


func physics_process(_delta):
	if owner.has_enough_gold():
		fsm.change_state_to(owner.states.STATE_GOTO_HOME)
	pass


func exit():
	if DEBUG: print("exit-state: dig")
	pass
